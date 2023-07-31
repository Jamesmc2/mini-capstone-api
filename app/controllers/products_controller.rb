class ProductsController < ApplicationController
  def all_products
    @products = Product.all
    render template: "products/index"
  end

  def football
    @product = Product.find_by(name: "Football")
    render template: "products/show"
  end
end
