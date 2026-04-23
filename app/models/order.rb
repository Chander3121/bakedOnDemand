class Order < ApplicationRecord
	has_many :order_items, dependent: :destroy

  enum :status, { pending: "pending", confirmed: "confirmed", cancelled: "cancelled" }
  enum :payment_status, { unpaid: "unpaid", paid: "paid", failed: "failed" }
end
