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
    if @product.errors.full_messages == []
      render template: "products/show"
    else
      render json: @product.errors.full_messages
    end
  end

  def update
    @product = Product.find_by(id: params[:id])
    @product.price = params[:price] || @product.price
    @product.name = params[:name] || @product.name
    @product.image_url = params[:image_url] || @product.image_url
    @product.description = params[:description] || @product.description
    @product.inventory_count = params[:inventory_count] || @product.inventory_count
    @product.supplier_id = params[:supplier_id] || @product.supplier_id

    @product.save
    if @product.errors.full_messages == []
      render template: "products/show"
    else
      render json: @product.errors.full_messages
    end
  end

  def delete
    @product = Product.find_by(id: params[:id])
    @product.destroy
    render json: { message: "The product has been deleted" }
  end
end

#create new table for images
#add url and product_id columns
#transfer existing urls over to images table
#delete urls from products table after the images table is connected
