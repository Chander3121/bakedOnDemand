class CreateProductVariants < ActiveRecord::Migration[8.1]
  def change
    create_table :product_variants do |t|
      t.references :product, null: false, foreign_key: true
      t.string :sku
      t.string :size
      t.string :flavor
      t.integer :stock, default: 0
      t.decimal :price, precision: 10, scale: 2, null: false

      t.timestamps
    end
  end
end
