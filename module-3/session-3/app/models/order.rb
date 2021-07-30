class Order
  attr_accessor :id, :order_date, :customer, :total, :items

  def initialize(params, customer, items, total)
    @id = params[:id]
    @order_date = params[:order_date]
    @customer = customer
    @items = items
    @total = total
  end

  def save

  end

  def update

  end

  def delete

  end

  def self.all
    client = create_db_client
    rawData = client.query("
        select customers.id, orders.order_date, customers.name, customers.phone, sum(items.price) as 'total', group_concat(items.name) as 'items'
        from orders
        join customers on customers.id = orders.customer_id
        join items on items.id = orders.item_id
        group by orders.customer_id, orders.order_date, customers.name, customers.phone
        order by orders.order_date asc;
      ")
    
      convert_sql_to_array(rawData)
  end

  def self.convert_sql_to_array(rawData)
    orders = Array.new
    rawData.each do |data|
      data.transform_keys!(&:to_sym)
      items = data[:items]
      total = data[:total]
      customer = Customer.new(data)
      order = Order.new(data, customer, items, total)
      orders << order
    end
    orders
  end
end