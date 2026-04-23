class CartItemsController < ApplicationController
  skip_before_action :authenticate_user!#, only: [:create]

  def create
    variant = ProductVariant.find(params[:product_variant_id])
    cart = current_cart

    item = cart.cart_items.find_by(product_variant_id: variant.id)

    if item
      item.increment!(:quantity, params[:quantity].to_i.presence || 1)
    else
      cart.cart_items.create!(
        product_variant: variant,
        quantity: params[:quantity] || 1
      )
    end

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to products_path, notice: "Added to cart 🛒" }
    end
  end

  def update
    @item = current_cart.cart_items.find(params[:id])
    @cart = current_cart

    if params[:quantity].to_i <= 0
      @item.destroy
    else
      @item.update(quantity: params[:quantity])
    end

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to cart_path }
    end
  end

  def destroy
    @item = current_cart.cart_items.find(params[:id])
    @item.destroy
    @cart = current_cart

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to cart_path }
    end
  end
end
