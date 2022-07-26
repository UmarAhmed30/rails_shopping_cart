class Item < ApplicationRecord
  belongs_to :cart
  delegate :total_price, to: :cart
  after_save :total_price
  after_destroy :total_price

  
end
