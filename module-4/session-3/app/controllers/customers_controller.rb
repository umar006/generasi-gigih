class CustomersController
  def self.create_customer(params)
    customer = Customer.new(params)
    customer.save
  end

  def self.update_customer(params)
    customer = Customer.new(params)
    customer.update
  end

  def self.delete_customer(params)
    customer = Customer.new(params)
    customer.delete
  end
end