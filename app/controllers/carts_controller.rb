class CartsController < ApplicationController
  before_action :set_cart, only: %i[show destroy]

  def index
    @carts = Cart.all
  end

  def show
    @items = @cart.items
  end

  def destroy
    respond_to do |format|
      if @cart.destroy
        format.html { redirect_to root_path, notice: 'Cart deleted successfully' }
      else
        format.html { redirect_to root_path, alert: 'Cart deletion failed' }
      end
    end
  end

  private

  def set_cart
    @cart = Cart.find(params[:id]) rescue not_found
  end
end
