class PaymentsController < ApplicationController
  skip_before_action :authenticate_user!
  require 'openssl'

  def show
    @order = Order.find(params[:order_id])
  end

  def verify
    order = Order.find(params[:order_id])

    generated_signature = OpenSSL::HMAC.hexdigest(
      "SHA256",
      ENV["RAZORPAY_SECRET_KEY"],
      "#{params[:razorpay_order_id]}|#{params[:razorpay_payment_id]}"
    )

    if generated_signature == params[:razorpay_signature]

      order.update!(
        payment_status: "paid",
        status: "confirmed",
        razorpay_payment_id: params[:razorpay_payment_id]
      )

      order.order_items.each do |item|
        variant = item.product_variant

        # Deduct actual stock
        variant.decrement!(:stock, item.quantity)

        # Release reserved stock
        variant.decrement!(:reserved_stock, item.quantity)
      end

      # clear cart
      current_cart.cart_items.destroy_all

      render json: { success: true }

    else
      order.update!(payment_status: "failed")
      order.order_items.each do |item|
        variant = item.product_variant
        variant.decrement!(:reserved_stock, item.quantity)
      end
      render json: { success: false }, status: :unprocessable_entity
    end
  end
end