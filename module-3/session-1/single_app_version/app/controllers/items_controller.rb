require 'erb'
require './app/models/item'

def get_all_categories
  client = create_db_client
  rawData = client.query("select * from categories")

  categories = Array.new
  rawData.each do |data|
    category = Category.new(data['name'], data['id'])
    categories.push(category)
  end

  categories
end

def get_all_item_with_categories
  client = create_db_client
  rawData = client.query("
      select items.id, items.name, items.price, categories.name as 'category_name', categories.id as 'category_id'
      from item_categories
      left join items on items.id = item_categories.item_id
      left join categories on categories.id = item_categories.category_id;
    ")

  items = Array.new

  rawData.each do | data |
    category = Category.new(data['category_name'], data['category_id'])
    item = Item.new(data['name'], data['price'], data['id'], category)

    items.push(item)
  end

  items
end

def add_new_item(name, price, category)
  client = create_db_client
  client.query("
      insert into items (name, price) values ('#{name}', '#{price}');
    ")
  
  item_id = client.query("
      select id
      from items
      where name='#{name}' and price='#{price}'
    ").each.first["id"]
  category_id = client.query("
      select id
      from categories
      where name='#{category}'
    ").each.first["id"]
  
  client.query("
      insert into item_categories values ('#{item_id}', '#{category_id}');
    ")
end

def get_detail_item(id)
  client = create_db_client
  data = client.query("
      select items.id, items.name, items.price, categories.name as 'category_name', categories.id as 'category_id'
      from item_categories
      join items on items.id = item_categories.item_id
      join categories on categories.id = item_categories.category_id
      where items.id = #{id}
    ").each.first

  category = Category.new(data['category_name'], data['category_id'])
  item = Item.new(data['name'], data['price'], data['id'], category)

  item
end

def update_item(item_id, name, price, category)
  client = create_db_client
  client.query("
      update items
      set name='#{name}', price='#{price}'
      where id='#{item_id}';
    ")

  category_id = client.query("
      select id
      from categories
      where name='#{category}'
    ").each.first["id"]

  client.query("
      update item_categories
      set category_id='#{category_id}'
      where item_id='#{item_id}';
    ")
end

def destroy_item(item_id)
  client = create_db_client
  client.query("
      delete from items
      where id='#{item_id}'
    ")
  client.query("
      delete from item_categories
      where item_id='#{item_id}';
    ")
end
