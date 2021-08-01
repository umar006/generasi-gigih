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
      it 'should return false when name and phone = nil' do
        expect(@customer_invalid.save).to eq(false)
      end
    end
  end

  describe '#update' do
    context 'given valid input' do
      it 'should update the customer' do
        expect(@dummy_database).to receive(:query).with("
            update customers
            set name='#{@customer_valid.name}', phone='#{@customer_valid.phone}'
            where id='#{@customer_valid.id}';
          ".gsub(/\s+/, ' '))

        @customer_valid.update
      end
    end

    context 'given invalid input' do
      it 'should return false when name and phone = nil' do
        expect(@customer_invalid.update).to eq(false)
      end
    end
  end

  describe '#delete' do
    context 'given valid input' do
      it 'should delete the customer' do
        expect(@dummy_database).to receive(:query).with("
            delete from customers
            where id='#{@customer_valid.id}';
          ".gsub(/\s+/, ' '))

        @customer_valid.delete
      end
    end
  end
end
