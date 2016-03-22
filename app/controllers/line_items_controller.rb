class LineItemsController < ApplicationController
  def create
    if !!current_user.current_cart
      current_user.current_cart.add_item(params[:item_id]).save
    else
      current_user.current_cart = current_user.carts.create
      current_user.current_cart.add_item(params[:item_id]).save
    end
    redirect_to current_user.current_cart
  end
end
