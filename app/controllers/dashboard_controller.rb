class DashboardController < ApplicationController

  def show
    render :profile
  end

  def profile
    @user = current_user
  end

  def orders
    @orders = current_user.orders.order(created_at: :desc)
  end

  def addresses
    @addresses = current_user.addresses
  end
end
