module ApplicationHelper
	def cart_count
    current_cart.cart_items.sum(:quantity)
  end

  def sidebar_link(section)
    base = "block px-3 py-2 rounded-lg transition"

    active =
      case section
      when "profile" then request.path.include?("profile")
      when "orders" then request.path.include?("orders")
      when "addresses" then request.path.include?("addresses")
      end

    active ? "#{base} bg-pink-50 text-pink-600 font-medium" : "#{base} hover:bg-gray-50"
  end

  def format_count(number)
    return 0 if number.blank?

    if number >= 1_000_000_000
      "#{(number / 1_000_000_000.0).round(1)}B"
    elsif number >= 1_000_000
      "#{(number / 1_000_000.0).round(1)}M"
    elsif number >= 1_000
      "#{(number / 1_000.0).round(1)}k"
    else
      number.to_s
    end
  end
end
