class AddReservedAtToOrders < ActiveRecord::Migration[8.1]
  def change
    add_column :orders, :reserved_at, :datetime
  end
end
