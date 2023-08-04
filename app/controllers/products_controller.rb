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
    @product = Product.new(
      name: params[:name],
      price: params[:price],
      image_url: params[:image_url],
      description: params[:description],
    )
    @product.save
    render template: "products/show"
  end

  def update
    @product = Product.find_by(id: params[:id])
    @product.price = params[:price] || @product.price
    @product.name = params[:name] || @product.name
    @product.image_url = params[:image_url] || @product.image_url
    @product.description = params[:description] || @product.description
    @product.inventory_count = params[:inventory_count] || @product.inventory_count
    @product.save
    render :show
  end

  def delete
    @product = Product.find_by(id: params[:id])
    @product.destroy
    render json: { message: "The product has been deleted" }
  end
end
