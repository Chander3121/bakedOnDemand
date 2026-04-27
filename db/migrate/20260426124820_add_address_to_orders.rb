class AddAddressToOrders < ActiveRecord::Migration[8.1]
  def change
    add_reference :orders, :address, null: false, foreign_key: true
    remove_column :orders, :address, :text
  end
end
