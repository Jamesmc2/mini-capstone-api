class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product
end

#create a new controller for orders
#create a new route for creating a new order
#make a create function in the orders controller
#allow a new order to be made only if a user is logged in
#allow a new order to be made only if a product has enough quantity
#if conditions are met, take params values and create a new order with them
#display all money values if an order is successfully made
