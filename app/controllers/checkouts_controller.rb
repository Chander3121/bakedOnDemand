class CheckoutsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @cart = current_cart
  end

  def create
    cart = current_cart

    ActiveRecord::Base.transaction do

      # 🔒 Lock all variants first (FOR UPDATE)
      variants = cart.cart_items.map do |item|
        ProductVariant.lock.find(item.product_variant_id)
      end

      # 🧠 Validate stock
      cart.cart_items.each do |item|
        variant = variants.find { |v| v.id == item.product_variant_id }

        if item.quantity > variant.available_stock
          raise ActiveRecord::Rollback, "Only #{variant.available_stock} left"
        end
      end

      # 🧾 Create order AFTER validation
      order = Order.create!(
        name: params[:name],
        phone: params[:phone],
        address: params[:address],
        status: "pending",
        payment_status: "unpaid",
        total_amount: calculate_total(cart),
        reserved_at: Time.current
      )

      # 🔒 Reserve stock
      cart.cart_items.each do |item|
        variant = variants.find { |v| v.id == item.product_variant_id }
        variant.increment!(:reserved_stock, item.quantity)
      end

      # 📦 Create order items
      cart.cart_items.each do |item|
        order.order_items.create!(
          product_variant: item.product_variant,
          quantity: item.quantity,
          price: item.product_variant.price
        )
      end

      # 💳 Razorpay order
      razorpay_order = Razorpay::Order.create(
        amount: (order.total_amount * 100).to_i,
        currency: "INR"
      )

      order.update!(razorpay_order_id: razorpay_order.id)

      redirect_to payment_path(order_id: order.id)
    end

  rescue => e
    redirect_to cart_path, alert: e.message
  end

  private

  def calculate_total(cart)
    cart.cart_items.sum { |i| i.quantity * i.product_variant.price }
  end
end