class CartedProductsController < ApplicationController
  def create
    @carted_product = CartedProduct.new(
      user_id: current_user.id,
      product_id: params[:product_id],
      order_id: nil,
      quantity: params[:quantity],
      status: "carted",
    )
    @carted_product.save
    render json: { message: "product added to cart" }
  end

  def index
    @carted_products = []
    if current_user
      current_user.carted_products.each do |carted_product|
        if carted_product.status == "carted"
          @carted_products << carted_product
        end
      end
      render :index
    else
      render json: { error: "you are not logged in" }
    end
  end
end
