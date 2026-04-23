# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.create!(email: "test@example.com", password: "password123")

ProductTag.delete_all
ProductVariant.delete_all
Product.delete_all
Category.delete_all
Tag.delete_all

puts "Seeding data..."

# -------------------------------
# 📂 Categories
# -------------------------------
cakes     = Category.create!(name: "Cakes", slug: "cakes")
pastries  = Category.create!(name: "Pastries", slug: "pastries")
cookies   = Category.create!(name: "Cookies", slug: "cookies")
breads    = Category.create!(name: "Breads", slug: "breads")

puts "Categories created"

# -------------------------------
# 🏷️ Tags
# -------------------------------
eggless     = Tag.create!(name: "Eggless")
bestseller  = Tag.create!(name: "Bestseller")
sugar_free  = Tag.create!(name: "Sugar Free")
gluten_free = Tag.create!(name: "Gluten Free")

puts "Tags created"

# -------------------------------
# 🧁 Products + Variants
# -------------------------------

# 🎂 Chocolate Cake
choco_cake = Product.create!(
  name: "Chocolate Truffle Cake",
  description: "Rich chocolate cake layered with creamy truffle frosting.",
  category: cakes,
  active: true
)

choco_cake.product_variants.create!([
  { sku: "CTC-500", size: "500g", flavor: "Chocolate", price: 400, stock: 10 },
  { sku: "CTC-1KG", size: "1kg", flavor: "Chocolate", price: 750, stock: 8 }
])

choco_cake.tags << [eggless, bestseller]

# 🎂 Red Velvet Cake
red_velvet = Product.create!(
  name: "Red Velvet Cake",
  description: "Soft and moist red velvet cake with cream cheese frosting.",
  category: cakes
)

red_velvet.product_variants.create!([
  { sku: "RVC-500", size: "500g", flavor: "Red Velvet", price: 450, stock: 6 },
  { sku: "RVC-1KG", size: "1kg", flavor: "Red Velvet", price: 850, stock: 5 }
])

red_velvet.tags << [bestseller]

# 🥐 Black Forest Pastry
black_forest = Product.create!(
  name: "Black Forest Pastry",
  description: "Classic pastry with chocolate sponge, whipped cream & cherries.",
  category: pastries
)

black_forest.product_variants.create!([
  { sku: "BFP-1", size: "Single Piece", flavor: "Chocolate", price: 120, stock: 20 }
])

black_forest.tags << [eggless]

# 🍪 Choco Chip Cookies
cookies_product = Product.create!(
  name: "Chocolate Chip Cookies",
  description: "Crunchy cookies loaded with chocolate chips.",
  category: cookies
)

cookies_product.product_variants.create!([
  { sku: "CCC-6", size: "Pack of 6", flavor: "Chocolate Chip", price: 200, stock: 15 },
  { sku: "CCC-12", size: "Pack of 12", flavor: "Chocolate Chip", price: 350, stock: 10 }
])

cookies_product.tags << [bestseller]

# 🍞 Garlic Bread
garlic_bread = Product.create!(
  name: "Garlic Bread",
  description: "Freshly baked bread topped with garlic butter.",
  category: breads
)

garlic_bread.product_variants.create!([
  { sku: "GB-REG", size: "Regular", flavor: "Garlic", price: 150, stock: 12 }
])

# 🎂 Sugar Free Cake
sugar_free_cake = Product.create!(
  name: "Sugar Free Chocolate Cake",
  description: "Delicious cake made with zero added sugar.",
  category: cakes
)

sugar_free_cake.product_variants.create!([
  { sku: "SFC-500", size: "500g", flavor: "Chocolate", price: 500, stock: 5 }
])

sugar_free_cake.tags << [sugar_free, eggless]

puts "Products & variants created"

puts "✅ Seeding completed successfully!"
