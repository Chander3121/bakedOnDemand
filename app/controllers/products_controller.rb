class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :cakes, :pastries]
  def index
    @products = Product.active.includes(:product_variants, :tags, images_attachments: :blob)
  end

  def show
    @product = Product.find(params[:id])
  end

  def cakes
    @cakes = Product.by_category("cakes")
  end

  def pastries
    @pastries = Product.by_category("pastries")
  end
end
