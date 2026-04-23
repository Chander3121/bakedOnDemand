class ProductVariant < ApplicationRecord
  belongs_to :product

  validates :price, presence: true
  validates :stock, numericality: { greater_than_or_equal_to: 0 }
end
