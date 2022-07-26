class Item < ApplicationRecord
  belongs_to :cart
  after_save_commit :total_price

  def total_price
    cart = Cart.find(cart_id)

    total = 0

    cart.items.each do |item|
      subtotal = item.quantity * item.price
      total += subtotal
    end

    cart.update(total:total)
  end
end
