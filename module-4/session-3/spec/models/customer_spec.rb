require_relative '../../config/env/development'
require_relative '../../app/models/customer'

describe Customer do
  before(:each) do
    @customer_valid = Customer.new({
                                     id: 99,
                                     name: 'umar',
                                     phone: '+6289689999'
                                   })

    @customer_invalid = Customer.new({
                                       id: 99,
                                       name: nil,
                                       phone: nil
                                     })

    @dummy_database = double
    allow(Mysql2::Client).to receive(:new).and_return(@dummy_database)
  end

  describe '#save' do
    context 'given valid input' do
      it 'should save to database' do
        expect(@dummy_database).to receive(:query).with("
            insert into customers (name, phone) values ('#{@customer_valid.name}', '#{@customer_valid.phone}');
          ".gsub(/\s+/, ' '))
        @customer_valid.save
      end
    end

    context 'given invalid input' do
      it 'should return false when given invalid input' do
        expect(@customer_invalid.save).to eq(false)
      end
    end
  end
end
