class Admin::DashboardController < Admin::BaseController

  def index
    # 📅 Filter
    range =
      case params[:range]
      when "today" then Time.zone.today.all_day
      when "week" then 1.week.ago..Time.current
      when "month" then 1.month.ago..Time.current
      else 1.week.ago..Time.current
      end

    orders = Order.where(created_at: range)

    # 📊 Stats
    @orders = orders.count
    @revenue = orders.sum(:total_amount)
    @products = Product.count
    @users = User.count

    # 📈 Charts
    @orders_by_day = orders.group_by_day(:created_at).count
    @revenue_by_day = orders.group_by_day(:created_at).sum(:total_amount)

    # 🥇 Top products
    @top_products = OrderItem
      .joins(:product_variant)
      .joins("INNER JOIN products ON products.id = product_variants.product_id")
      .group("products.name")
      .sum("order_items.quantity")

    # 🔎 Search
    if params[:q].present?
      @recent_orders = Order.where("name ILIKE ?", "%#{params[:q]}%")
                            .order(created_at: :desc)
                            .limit(5)
    else
      @recent_orders = Order.order(created_at: :desc).limit(5)
    end
  end
end
