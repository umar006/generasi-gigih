class Category
  attr_accessor :name, :id

  def initialize(name, id=nil)
    @name = name
    @id = id
  end

  def self.add(name)
    client = create_db_client
    client.query("
        insert into categories (name) values ('#{name}');
      ")
  end

  def self.update(id, name)
    client = create_db_client
    client.query("
      update categories
      set name='#{name}'
      where id='#{id}';
      ")
  end

  def self.delete(id)
    client = create_db_client
    client.query("
        delete from categories
        where id='#{id}';
      ")
    client.query("
        update item_categories
        set category_id=null
        where category_id='#{id}'
      ")
  end

  def self.all
    client = create_db_client
    rawData = client.query("select * from categories")

    categories = Array.new
    rawData.each do |data|
      category = Category.new(data['name'], data['id'])
      categories << category
    end

    categories
  end

  def self.items_by_category(category_id)
    client = create_db_client
    rawData = client.query("
        select items.name, items.price, items.id
        from item_categories
        join items on items.id = item_categories.item_id
        join categories on categories.id = item_categories.category_id
        where categories.id = #{category_id};
      ")
    
    items = Array.new
    rawData.each do |data|
      item = Item.new(data['name'], data['price'], data['id'])
      items << item
    end

    items
  end

  def self.find_by_id(id)
    client = create_db_client

    data = client.query("
        select categories.name, categories.id
        from categories
        where categories.id = #{id};
      ").each.first
    
    category = Category.new(data['name'], data['id'])

    category
  end
end