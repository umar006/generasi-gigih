class Item
  attr_accessor :name, :price, :id, :category

  def initialize(params, category=nil)
    @id = params[:id]
    @name = params[:name]
    @price = params[:price]
    @category = category
  end

  def save
    client = create_db_client
    client.query("insert into items (name, price) values ('#{@name}', '#{@price}');")
    
    item_id = client.query("
        select id
        from items
        where name='#{@name}' and price='#{@price}'
      ").each.first["id"]
    category_id = client.query("
        select id
        from categories
        where name='#{@category.name}'
      ").each.first["id"]
    
    client.query("
        insert into item_categories values ('#{item_id}', '#{category_id}');
      ")
  end

  def update
    client = create_db_client
    client.query("
        update items
        set name='#{@name}', price='#{@price}'
        where id='#{@id}';
      ")

    category_id = client.query("
        select id
        from categories
        where name='#{@category.name}'
      ").each.first["id"]

    client.query("
        update item_categories
        set category_id='#{category_id}'
        where item_id='#{@id}';
      ")
  end

  def delete
    client = create_db_client
    client.query("
        delete from items
        where id='#{@id}'
      ")
    client.query("
        delete from item_categories
        where item_id='#{@id}';
      ")
  end

  def self.all_with_categories
    client = create_db_client
    rawData = client.query("
        select items.id, items.name, items.price, categories.name as 'category_name', categories.id as 'category_id'
        from item_categories
        left join items on items.id = item_categories.item_id
        left join categories on categories.id = item_categories.category_id;
      ")

    convert_sql_to_array(rawData)
  end

  def self.find_by_id(id)
    client = create_db_client
    rawData = client.query("
        select items.id, items.name, items.price, categories.name as 'category_name', categories.id as 'category_id'
        from item_categories
        join items on items.id = item_categories.item_id
        left join categories on categories.id = item_categories.category_id
        where items.id = #{id}
      ")

    convert_sql_to_array(rawData)
  end

  def self.where(category_id)
    client = create_db_client
    rawData = client.query("
        select items.name, items.price, items.id
        from item_categories
        join items on items.id = item_categories.item_id
        left join categories on categories.id = item_categories.category_id
        where categories.id = #{category_id};
      ")
    
    convert_sql_to_array(rawData)
  end

  def self.convert_sql_to_array(rawData)
    items = Array.new
    rawData.each do |data|
      data.transform_keys!(&:to_sym)
      category = Category.new(data)
      item = Item.new(data, category)
      items << item
    end
    items
  end
end