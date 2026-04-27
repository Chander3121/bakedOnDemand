class OrdersController < ApplicationController
  # skip_before_action :authenticate_user!

  def index
    @orders = current_user.orders.order(created_at: :desc)
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def success
    @order = Order.find(params[:id])
  end

  def track
  end

  def find
    @order = Order.find_by(
      id: params[:order_id],
      phone: params[:phone]
    )

    if @order
      redirect_to order_path(@order)
    else
      redirect_to track_order_path, alert: "Order not found"
    end
  end
end
