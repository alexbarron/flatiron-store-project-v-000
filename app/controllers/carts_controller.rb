class CartsController < ApplicationController
  def show
    @user = current_user
  end

  def checkout
    cart = current_user.current_cart
    cart.checkout
    redirect_to cart_path(cart.id)
  end
end
