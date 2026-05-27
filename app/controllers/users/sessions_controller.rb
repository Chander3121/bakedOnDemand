class Users::SessionsController < Devise::SessionsController

  before_action :store_guest_cart, only: [:create]

  private

  def store_guest_cart
    session[:guest_cart_id] = session[:cart_id] if session[:cart_id].present?
  end
end
