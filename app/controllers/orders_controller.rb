class OrdersController < ApplicationController
  skip_before_action :authenticate_user!
  def success
    @order = Order.find(params[:id])
  end
end
