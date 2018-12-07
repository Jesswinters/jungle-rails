class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @product = Product.find params[:id]
    @review = Review.new
  end

  private

  def set_product
    @product = Product.find(prams[:id])
  end

end
