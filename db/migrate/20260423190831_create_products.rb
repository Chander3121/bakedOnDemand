class CreateProducts < ActiveRecord::Migration[8.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description
      t.references :category, null: false, foreign_key: true
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
