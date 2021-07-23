require './db/db_connector'

class Item
  attr_accessor :name, :price, :id, :category

  def initialize(name, price, id=nil, category=nil)
    @name = name
    @price = price
    @id = id
    @category = category
  end

  def save
    return false unless valid?

    client = create_db_client
    client.query("
        insert into items (name, price) values ('#{name}', '#{price}');
      ")
    
    item_id = client.query("
        select id
        from items
        where name='#{@name}' and price='#{@price}'
      ").each.first["id"]
    category_id = client.query("
        select id
        from categories
        where name='#{@category}'
      ").each.first["id"]
    
    client.query("
        insert into item_categories values ('#{item_id}', '#{category_id}');
      ")
  end

  def valid?
    return false if name.nil?
    return false if price.nil?
    return false if id.nil?

    true
  end
end