class CheckoutsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @cart = current_cart
  end

  def create
    cart = current_cart

    order = Order.create!(
      name: params[:name],
      phone: params[:phone],
      address: params[:address],
      status: "pending",
      payment_status: "unpaid",
      total_amount: calculate_total(cart)
    )

    cart.cart_items.each do |item|
      order.order_items.create!(
        product_variant: item.product_variant,
        quantity: item.quantity,
        price: item.product_variant.price
      )
    end

    # Razorpay order create
    razorpay_order = Razorpay::Order.create(
      amount: (order.total_amount * 100).to_i,
      currency: "INR"
    )

    order.update!(razorpay_order_id: razorpay_order.id)

    redirect_to payment_path(order_id: order.id)
  end

  private

  def calculate_total(cart)
    cart.cart_items.sum { |i| i.quantity * i.product_variant.price }
  end
end