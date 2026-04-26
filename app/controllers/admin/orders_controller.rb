class Admin::OrdersController < Admin::BaseController
  before_action :require_admin!

  def index
    @orders = Order.order("#{sort_column} #{sort_direction}").page(params[:page]).per(1)
  end

  def show
    @order = Order.includes(order_items: { product_variant: :product }).find(params[:id])
  end

  def update
    @order = Order.find(params[:id])

    if @order.update(order_params)
      redirect_to admin_order_path(@order), notice: "Status updated"
    else
      render :show
    end
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

  def sort_column
    %w[id name status total_amount created_at].include?(params[:sort]) ? params[:sort] : "created_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end
