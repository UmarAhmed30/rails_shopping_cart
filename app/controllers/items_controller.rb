class ItemsController < ApplicationController
  before_action :set_cart_and_item

  def update
    respond_to do |format|
      if @item.update(item_params)
        flash[:notice] = 'Item updated successfully'
        format.json { render json: { status: 200 } }
      else
        flash[:alert] = 'Item updation failed'
        format.json { render json: { status: 501 } }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @item.destroy
        format.html { redirect_to cart_path(@cart), notice: 'Item deleted from cart successfully' }
      else
        format.html { redirect_to cart_path(@cart), alert: 'Item deletion failed' }
      end
    end
  end

  private

  def set_cart_and_item
    @cart = Cart.find(params[:cart_id])
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:quantity)
  end
end
