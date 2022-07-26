class Cart < ApplicationRecord
  has_many :items, dependent: :destroy

  def total_price
    total = 0

    self.items.each do |item|
      subtotal = item.quantity * item.price
      total += subtotal
    end

    self.update(total:total)
  end
end
