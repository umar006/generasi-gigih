class Category
  attr_accessor :name, :id

  def initialize(params)
    @name = params[:category_name]
    @id = params[:category_id]
    p params
  end

  def save
    client = create_db_client
    client.query("
        insert into categories (name) values ('#{@name}');
      ")
  end

  def update
    client = create_db_client
    client.query("
      update categories
      set name='#{@name}'
      where id='#{@id}';
      ")
  end

  def delete
    client = create_db_client
    client.query("
        delete from categories
        where id='#{@id}';
      ")
    client.query("
        update item_categories
        set category_id=null
        where category_id='#{@id}'
      ")
  end

  def self.all
    client = create_db_client
    rawData = client.query("
        select categories.id as 'category_id', categories.name as 'category_name'
        from categories
      ")

    categories = Array.new
    rawData.each do |data|
      data.transform_keys!(&:to_sym)
      category = Category.new(data)
      categories << category
    end

    categories
  end

  def self.find_by_id(id)
    client = create_db_client

    data = client.query("
        select categories.id as 'category_id', categories.name as 'category_name'
        from categories
        where categories.id = #{id};
      ").each.first
    
    data.transform_keys!(&:to_sym)
    category = Category.new(data)

    category
  end
end