class ProductVariant < ApplicationRecord
  belongs_to :product

  has_many :cart_items

  validates :price, presence: true
  validates :stock, numericality: { greater_than_or_equal_to: 0 }
end
