class Customer
  attr_accessor :id, :name, :phone

  def initialize(params)
    @id = params[:id]
    @name = params[:name]
    @phone = params[:phone]
  end

  def save
    return false unless valid?

    client = create_db_client
    client.query("
        insert into customers (name, phone) values ('#{@name}', '#{@phone}');
      ".gsub(/\s+/, ' '))

    true
  end

  def update
    return false unless valid?

    client = create_db_client
    client.query("
        update customers
        set name='#{@name}', phone='#{@phone}'
        where id='#{@id}';
      ".gsub(/\s+/, ' '))

    true
  end

  def delete
    return false unless valid?

    client = create_db_client
    client.query("
        delete from customers
        where id='#{@id}';
      ".gsub(/\s+/, ' '))

    true
  end

  def valid?
    return false if @name.nil? || @phone.nil?

    true
  end

  def self.all
    client = create_db_client
    rawData = client.query("
        select * from customers
      ")

    convert_sql_to_array(rawData)
  end

  def self.convert_sql_to_array(rawData)
    customers = []
    rawData.each do |data|
      data.transform_keys!(&:to_sym)
      customer = Customer.new(data)
      customers << customer
    end
    customers
  end
end
