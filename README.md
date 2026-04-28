# 🍰 BakesOnDemand

![Rails](https://img.shields.io/badge/Rails-8.x-red)
![Ruby](https://img.shields.io/badge/Ruby-3.x-red)
![Hotwire](https://img.shields.io/badge/Hotwire-Turbo%20%2B%20Stimulus-blue)
![License](https://img.shields.io/badge/License-MIT-green)
![Status](https://img.shields.io/badge/Status-Active-success)

A **full-stack bakery e-commerce platform** built with Ruby on Rails, featuring a premium UI, real-time interactions, and a scalable architecture ready for mobile integration.

---


## 🎬 Demo

🔗 **Live Demo:** https://your-demo-link.com
📽️ **Video Walkthrough:** https://your-video-link.com  

---


## 📸 Screenshots

### 🏠 Landing Page
![Landing](https://drive.google.com/file/d/168MNeNjoGeai2IddUy1iJFYV_2ow9YEL/view?usp=drive_link)


### 🛍️ Products Page (Filters + Search)
![Products](docs/screenshots/products.png)

### 🧑‍💼 Admin Dashboard
![Admin](docs/screenshots/admin.png)

### 👤 User Dashboard
![Dashboard](docs/screenshots/user_dashboard.png)

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
```

### 2. Install dependencies
```bash
bundle install
```

### 3. Setup database
```bash
rails db:create
rails db:migrate
```

### 4. Start server
```bash
bin/dev
```

👉 Visit: http://localhost:3000

---

### 💳 Razorpay Setup

Add your keys in credentials:
```bash
razorpay:
  key_id: YOUR_KEY
  key_secret: YOUR_SECRET
```

---

### 👤 Authentication

- Devise-based authentication
- Login required for checkout
- Supports future guest checkout flow

### 📁 Important Paths
| Feature	   | Path |
|------------|-----|
| Products   | /products |
| Cart	     | /cart |
| Checkout   | /checkout |
| Dashboard	 | /dashboard |
| Admin	     | /admin |

---

### 🎨 UI Highlights

- Premium landing page
- Glassmorphism dropdown
- Sticky filters
- Infinite scroll
- Interactive product cards
- Delivery progress tracker
- Modern dashboard UI

---

### 🔮 Future Improvements

- Wishlist ❤️
- Reviews & ratings ⭐
- Coupon system 🎟️
- Notifications 🔔
- Mobile app via GraphQL
- Background jobs (Sidekiq)

---

### 🤝 Contributing

Pull requests are welcome.
For major changes, open an issue first.

---

### 📄 License

MIT License

---

### 👨‍💻 Author

Chander Prakash
