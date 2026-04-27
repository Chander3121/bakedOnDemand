class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :cakes, :pastries]

  def index
    @products = Product.active.includes(:category, :product_variants, :tags, images_attachments: :blob)

    # 🔍 Search
    if params[:query].present?
      @products = @products.where("name ILIKE ?", "%#{params[:query]}%")
    end

    # 📂 Category
    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
    end

    # 🏷️ Tags (multi-select)
    if params[:tag_ids].present?
      @products = @products.joins(:tags)
                           .where(tags: { id: params[:tag_ids] })
    end

    # 💰 Price
    if params[:min_price].present?
      @products = @products.joins(:product_variants)
                           .where("product_variants.price >= ?", params[:min_price])
    end

    if params[:max_price].present?
      @products = @products.joins(:product_variants)
                           .where("product_variants.price <= ?", params[:max_price])
    end

    case params[:sort]
    when "price_low"
      @products = @products.joins(:product_variants).order("product_variants.price ASC")
    when "price_high"
      @products = @products.joins(:product_variants).order("product_variants.price DESC")
    when "latest"
      @products = @products.order(created_at: :desc)
    end

    # 🔁 Infinite scroll (simple)
    @products = @products.limit(12).offset(params[:offset].to_i)

    @categories = Category.all
    @tags = Tag.all

    respond_to do |format|
      format.html
      format.turbo_stream
    end
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
