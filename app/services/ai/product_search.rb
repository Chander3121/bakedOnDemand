class Ai::ProductSearch

  STOP_WORDS = %w[
    is
    there
    any
    for
    with
    a
    an
    the
    cake
    cakes
    flavoured
    flavored
    suggest
    me
    please
    cheap
    under
    below
    above
    less
    than
  ]

  def self.call(query)

    # 🎯 Extract price filters
    max_price = query[/under\s+(\d+)/i, 1]
    min_price = query[/above\s+(\d+)/i, 1]

    # 🎯 Clean query
    keywords =
      query.downcase
           .split
           .reject do |k|
             STOP_WORDS.include?(k) || k.match?(/\d+/)
           end

    cleaned_query = keywords.join(" ")

    products = Product.ai_search(cleaned_query)

    # 🎯 Apply price filters
    products =
      products.joins(:product_variants)

    if max_price.present?
      products =
        products.where(
          "product_variants.price <= ?",
          max_price.to_i
        )
    end

    if min_price.present?
      products =
        products.where(
          "product_variants.price >= ?",
          min_price.to_i
        )
    end

    products.limit(3)
  end
end
