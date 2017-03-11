class LineItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.create_cart if !current_cart
    line_item = current_cart.add_item(params[:item_id])

    if line_item.save
      redirect_to cart_path(current_cart), notice: "Item added"
    else
      redirect_to store_path, notice: "Can't add item"
    end
  end

end
