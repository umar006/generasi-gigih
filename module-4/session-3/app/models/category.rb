class Category
  attr_accessor :name, :id

  def initialize(params)
    @name = params[:category_name]
    @id = params[:category_id]
  end

  def save
    return false unless valid?

    client = create_db_client
    client.query("
        insert into categories (name) values ('#{@name}');
      ".gsub(/\s+/, " "))

      true
  end

  def update
    return false unless valid?

    client = create_db_client
    client.query("
      update categories
      set name='#{@name}'
      where id='#{@id}';
      ".gsub(/\s+/, " "))

      true
  end

  def delete
    return false unless valid?

    client = create_db_client
    client.query("
        delete from categories
        where id='#{@id}';
      ".gsub(/\s+/, " "))
    client.query("
        update item_categories
        set category_id=null
        where category_id='#{@id}'
      ".gsub(/\s+/, " "))

      true
  end

  def valid?
    return false if @name.nil?
    true
  end

  def self.all
    client = create_db_client
    rawData = client.query("
        select categories.id as 'category_id', categories.name as 'category_name'
        from categories
      ")

    convert_sql_to_array(rawData)
  end

  def self.find_by_id(id)
    client = create_db_client

    rawData = client.query("
        select categories.id as 'category_id', categories.name as 'category_name'
        from categories
        where categories.id = #{id};
      ")
    
    convert_sql_to_array(rawData)
  end

  def self.convert_sql_to_array(rawData)
    categories = Array.new
    rawData.each do |data|
      data.transform_keys!(&:to_sym)
      category = Category.new(data)
      categories << category
    end
    categories
  end
end