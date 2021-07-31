class CategoriesController
  def self.create_category(params)
    category = Category.new(params)
    category.save
  end

  def self.update_category(params)
    category = Category.new(params)
    category.update
  end

  def self.delete_category(params)
    category = Category.new(params)
    category.delete
  end
end