class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    redirect_to store_path, alert: "You cart is empty" if !current_cart
  end

  def checkout
    @cart = Cart.find_by(id: params[:id])
    return redirect_to store_path, alert: "Access denied." if !current_user.carts.include?(@cart)
    @cart.checkout
    redirect_to cart_path, notice: "Successfully checked out"
  end
end
