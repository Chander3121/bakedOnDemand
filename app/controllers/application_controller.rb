class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  before_action :authenticate_user!

  def current_cart
    if session[:cart_id]
      Cart.find_by(id: session[:cart_id]) || create_cart
    else
      create_cart
    end
  end

  def create_cart
    cart = Cart.create!
    session[:cart_id] = cart.id
    cart
  end

  helper_method :current_cart

  def require_admin!
    redirect_to root_path, alert: "Not authorized" unless current_user&.admin?
  end
end
