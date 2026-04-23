class AddReservedStockToProductVariants < ActiveRecord::Migration[8.1]
  def change
    add_column :product_variants, :reserved_stock, :integer
  end
end
