class AddIndexesOnSomeColumns < ActiveRecord::Migration[8.1]
  def change
    add_index :product_variants, :sku, unique: true
    add_index :products, :name
  end
end
