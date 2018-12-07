class ReviewsController < ApplicationController

  before_action :set_review, only: [:destroy]

  def create

    @review = Review.new(review_params)
    @product = Product.find(params[:product_id])
    @review.product = @product
    @review.user_id = session[:user_id]

    if @review.save!
      redirect_to @product, notice: 'Review successfully created'
    else
      render @product
    end

  end

  def destroy
    @review.destroy
    redirect_to @review.product, notice: 'Review deleted'
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:rating, :description)
  end

end
