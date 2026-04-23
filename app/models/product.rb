class Product < ApplicationRecord
  belongs_to :category

  has_many :product_variants, dependent: :destroy
  has_many :product_tags, dependent: :destroy
  has_many :tags, through: :product_tags

  has_many_attached :images

  scope :active, -> {where(active: true)}
  scope :by_category, ->(slug) {
    joins(:category).where(categories: { slug: slug })
  }
end
