class AiChatsController < ApplicationController

  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!

  def create

    query = params[:message]

    # 🔥 Fetch products context
    products = Ai::ProductSearch.call(query)

    product_context = products.map do |p|
      price = p.product_variants.minimum(:price)

      "- #{p.name} | ₹#{price}"
    end.join("\n")

    # 🔥 OpenAI Prompt
    prompt = <<~PROMPT
      You are a bakery AI assistant.

      User query:
      #{query}

      These are the ONLY available matching products:

      #{product_context}

      IMPORTANT RULES:
      - Recommend ONLY products from the provided list
      - Never invent products
      - Never say products are unavailable if products exist
      - Mention prices correctly
      - Keep response short and friendly
      - We are using Indian currency

      If products exist:
      recommend the best option.

      If no products exist:
      politely say no matching products found.
      PROMPT

    response = OPENAI_CLIENT.chat(
      parameters: {
        model: "openai/gpt-3.5-turbo",
        messages: [
          {
            role: "user",
            content: prompt
          }
        ]
      }
    )

    answer =
      response.dig(
        "choices",
        0,
        "message",
        "content"
      )

    render json: {
      message: answer,
      products: products.map do |product|

        {
          id: product.id,
          name: product.name,
          price: product.product_variants.minimum(:price),
          image: (
            url_for(product.images.first) if product.images.attached?
          ),
          rating: product.average_rating
        }

      end
    }
  end
end
