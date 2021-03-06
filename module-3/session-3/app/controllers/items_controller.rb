class ItemsController
  def self.create_item(params)
    category = Category.new(params)
    item = Item.new(params, category)
    item.save
  end

  def self.update_item(params)
    category = Category.new(params)
    item = Item.new(params, category)
    item.update
  end

  def self.delete_item(params)
    item = Item.new(params)
    item.delete
  end
end