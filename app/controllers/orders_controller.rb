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
    subtotal = 0
    if current_user
      current_user.carted_products.each do |carted_product|
        if carted_product.status == "carted"
          subtotal += (carted_product.product.price * carted_product.quantity)
        end
      end
      order = Order.new(
        user_id: current_user.id,
        subtotal: subtotal,
        tax: subtotal * 0.09,
        total: subtotal + (subtotal * 0.09),
      )
      order.save
      current_user.carted_products.each do |carted_product|
        if carted_product.status == "carted"
          carted_product.status = "purchased"
          carted_product.order_id = order.id
          carted_product.save
        end
      end
      if order.save
        render json: { message: "your order was made" }
      else
        render json: { error: order.errors.full_messages }
      end
    else
      render json: { error: "you are not logged in" }
    end
  end
end
