class Admin::ProductsController < Admin::BaseController
  before_action :set_product, only: [:edit, :update, :destroy]

  def index
	  @products = Product.includes(:category, :product_variants, :tags)

	  if params[:query].present?
	    @products = @products.where("name ILIKE ?", "%#{params[:query]}%")
	  end

	  @products = @products.order(created_at: :desc)
	end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to admin_products_path, notice: "Product created"
    else
      render :new
    end
  end

  def edit; end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to admin_products_path, notice: "Updated" }
      end
    else
      render :show
    end
  end

  def destroy
    @product.destroy
    redirect_to admin_products_path, notice: "Deleted"
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
	  params.require(:product).permit(
	    :name,
	    :description,
	    :category_id,
	    images: [],
	    tag_ids: [],
	    product_variants_attributes: [:id, :size, :price, :stock, :_destroy]
	  )
	end
end
