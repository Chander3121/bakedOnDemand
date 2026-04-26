module OrdersHelper
  def order_step_index(status)
    {
      "pending" => 0,
      "confirmed" => 1,
      "preparing" => 2,
      "out_for_delivery" => 3,
      "delivered" => 4
    }[status] || 0
  end
end
