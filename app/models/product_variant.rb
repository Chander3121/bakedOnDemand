class ProductVariant < ApplicationRecord
  belongs_to :product

  has_many :cart_items

  validates :price, presence: true
  validates :stock, numericality: { greater_than_or_equal_to: 0 }

  after_update_commit -> {
    broadcast_replace_to "product_variant_#{id}",
    partial: "products/stock",
    locals: { variant: self }
  }

  def available_stock
    stock - (reserved_stock || 0)
  end
end
