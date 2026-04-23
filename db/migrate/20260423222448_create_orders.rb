class CreateOrders < ActiveRecord::Migration[8.1]
  def change
    create_table :orders do |t|
      t.string :status
      t.decimal :total_amount, precision: 10, scale: 2
      t.string :payment_status
      t.string :payment_method
      t.string :razorpay_order_id
      t.string :razorpay_payment_id
      t.string :name
      t.string :phone
      t.text :address

      t.timestamps
    end
  end
end
