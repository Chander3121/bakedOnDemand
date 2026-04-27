# 🍰 BakesOnDemand

A modern **bakery e-commerce platform** built with Ruby on Rails.  
Supports **web (Rails views)** + scalable architecture for future mobile apps.

---

## 🚀 Features

### 🛍️ Customer Side
- Browse products with **filters (category, tags, price)**
- **Turbo-powered live search & filtering**
- Product variants (size, price, stock)
- Add to cart & checkout flow
- Razorpay payment integration
- Order success page with **delivery tracker**
- User authentication (Devise)
- User dashboard:
  - Profile
  - Orders
  - Saved addresses

---

### 🧑‍💼 Admin Panel
- Manage products (CRUD)
- Dynamic product variants
- Category & Tag management
- Orders management & status update
- Dashboard with analytics
- Premium UI with sidebar

---

### ⚡ Tech Stack

- Ruby on Rails 8
- Turbo + Stimulus (Hotwire)
- Active Storage (image uploads)
- Kaminari (pagination)
- Razorpay (payments)
- TailwindCSS

---

## 🧱 Architecture

- MVC (Rails standard)
- Modular structure (Admin + User + Storefront)
- GraphQL-ready (future mobile support)
- Clean separation of concerns

---

## 📦 Models

- User (Devise, roles: admin/customer)
- Product
- ProductVariant
- Category
- Tag
- Cart / CartItem
- Order / OrderItem
- Address

---

## 🛠️ Setup Instructions

### 1. Clone the repository

```bash
git clone https://github.com/Chander3121/bakedOnDemand.git
cd bakes_on_demand
