class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :line_items
  has_many :items, through: :line_items

  def total
    self.line_items.inject(0) {|sum, line_item| sum + line_item.quantity * line_item.item.price}
  end

  def add_item(item_id)
    if line_item = LineItem.find_by(cart_id: self.id, item_id: item_id)
      line_item.quantity += 1
      return line_item
    else
      return LineItem.new(item_id: item_id, cart_id: self.id)
    end
  end

  def checkout
    self.line_items.each do |line_item|
      item = line_item.item
      item.inventory -= line_item.quantity
      item.save
    end
    self.status = "submitted"
    self.save
    user.current_cart = nil
  end


end
