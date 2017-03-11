class Cart < ActiveRecord::Base

  belongs_to :user
  has_many :line_items
  has_many :items, through: :line_items

  def total
    self.line_items.reduce(0) do |total_price, line_item|
      total_price + line_item.total
    end
  end

  def add_item(item_id)
    line_item = self.line_items.find_by(item_id: item_id)
    if line_item.present?
      line_item.quantity += 1
      line_item
    else
      self.line_items.build(item_id: item_id, quantity: 1)
    end
  end

  def checkout
    self.line_items.each do |line_item|
      new_inventory = line_item.item.inventory -= line_item.quantity
      line_item.item.update(inventory: new_inventory)
    end
    self.status = "submitted"
    self.user.checkout_current_cart
  end

end
