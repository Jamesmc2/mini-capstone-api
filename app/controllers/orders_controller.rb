class OrdersController < ApplicationController
  before_action :authenticate_user

  def show
    @order = Order.find_by(id: params[:id])
    if current_user.id == @order.user_id
      render :show
    else
      render json: { error: "You must be logged into the user who made this order to view it" }
    end
  end

  def index
    @orders = Order.where(user_id: current_user.id)
    render :index
  end

  def create
    product = Product.find_by(id: params[:product_id])
    @order = Order.new(
      user_id: current_user.id,
      product_id: params[:product_id],
      quantity: params[:quantity],
      subtotal: (product.price * params[:quantity].to_i),
      tax: (product.price * params[:quantity].to_i * 0.09),
      total: (product.price * params[:quantity].to_i) + (product.price * params[:quantity].to_i * 0.09),
    )
    @order.save
    if @order.save
      render :show
    else
      render json: { error: "order not made" }
    end
  end
end
