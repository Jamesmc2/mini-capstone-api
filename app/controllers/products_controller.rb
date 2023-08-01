class ProductsController < ApplicationController
  def index
    @products = Product.all
    render template: "products/index"
  end

  def show
    @product = Product.find_by(id: params[:id])
    render template: "products/show"
  end

  def create
    @product = Product.new(name: "baseball", price: 5, image_url: "https://upload.wikimedia.org/wikipedia/en/1/1e/Baseball_%28crop%29.jpg", description: "A white ball used for playing baseball")
    @product.save
    render template: "products/show"
  end
end
