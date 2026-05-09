class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new(review_params.merge(user: current_user))

    if @review.save
      redirect_to product_path(@product), notice: "Review added!"
    else
      redirect_to product_path(@product), alert: @review.errors.full_messages.to_sentence
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
