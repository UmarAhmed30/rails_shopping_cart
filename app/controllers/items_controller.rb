class ItemsController < ApplicationController
  before_action :set_cart

  def update
    @item = @cart.items.find(params[:id])
    old_quantity = @item.quantity

    respond_to do |format|
      if @item.update(quantity: params[:quantity])
        if @cart.update(total: @cart.total - (old_quantity * @item.price) + (@item.quantity * @item.price))
          flash[:notice] = 'Item updated successfully'
          format.json { render json: { status: 200 } }
        else
          flash[:alert] = 'Item updation failed'
          format.json { render json: { status: 501 } }
        end
      end
    end
  end

  def destroy
    @item = @cart.items.find(params[:id])
    old_subtotal = @item.quantity * @item.price
    respond_to do |format|
      if @item.destroy
        @cart.update(total: @cart.total - old_subtotal)
        format.html { redirect_to cart_path(@cart), notice: 'Item deleted from cart successfully' }
      else
        format.html { redirect_to cart_path(@cart), alert: 'Item deletion failed' }
      end
    end
  end

  private

  def set_cart
    @cart = Cart.find(params[:cart_id])
  end
end
