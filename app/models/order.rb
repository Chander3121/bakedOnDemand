class Order < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :address
	has_many :order_items, dependent: :destroy

  enum :status, { pending: "pending", confirmed: "confirmed", cancelled: "cancelled" }
  enum :payment_status, { unpaid: "unpaid", paid: "paid", failed: "failed" }
end
