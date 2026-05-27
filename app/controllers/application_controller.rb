class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  before_action :authenticate_user!
  before_action :store_user_location!, if: :storable_location?
  before_action :configure_permitted_parameters, if: :devise_controller?

  def current_cart

    if user_signed_in?
      # debugger
      user_cart = current_user.cart || current_user.create_cart!

      # Merge guest cart
      if session[:guest_cart_id].present?

        guest_cart = Cart.find_by(id: session[:guest_cart_id])

        if guest_cart.present? && guest_cart.id != user_cart.id

          guest_cart.cart_items.each do |item|

            existing_item = user_cart.cart_items.find_by(
              product_variant_id: item.product_variant_id
            )

            if existing_item
              existing_item.increment!(:quantity, item.quantity)
              item.destroy!
            else
              item.update!(cart: user_cart)
            end

          end

          guest_cart.destroy!
        end

        session.delete(:guest_cart_id)
      end

      session[:cart_id] = user_cart.id

      user_cart

    else

      if session[:cart_id]
        Cart.find_by(id: session[:cart_id]) || create_cart
      else
        create_cart
      end

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

  def after_sign_in_path_for(resource)
    if session.delete(:checkout_flow)
      "#{new_checkout_path}?reload=true"
    else
      stored_location_for(resource) || root_path
    end
  end

  def after_sign_up_path_for(resource)
    if session.delete(:checkout_flow)
      "#{new_checkout_path}?reload=true"
    else
      stored_location_for(resource) || root_path
    end
  end

  def store_user_location!
    store_location_for(:user, params[:return_to]) if params[:return_to].present?
  end

  def storable_location?
    request.get? && is_navigational_format?
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:phone])
    devise_parameter_sanitizer.permit(:account_update, keys: [:phone])
  end
end
