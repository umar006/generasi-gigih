require_relative '../../config/env/development'
require_relative '../../app/models/category'

describe Category do
  before(:each) do
    @category = Category.new({
                               category_id: 6,
                               category_name: 'candy'
                             })

    @category_invalid = Category.new({
                                       category_id: 6,
                                       category_name: nil
                                     })

    @dummy_database = double
    allow(Mysql2::Client).to receive(:new).and_return(@dummy_database)
  end

  describe '#save' do
    context 'given valid input' do
      it 'should save to database' do
        expect(@dummy_database).to receive(:query).with("
            insert into categories (name) values ('#{@category.name}');
          ".gsub(/\s+/, ' '))

        @category.save
      end
    end

    context 'given invalid input' do
      it 'should return false when category_name is nil' do
        expect(@category_invalid.save).to eq(false)
      end
    end
  end

  describe '#update' do
    context 'given valid input' do
      it 'should update the category' do
        expect(@dummy_database).to receive(:query).with("
            update categories
            set name='#{@category.name}'
            where id='#{@category.id}';
          ".gsub(/\s+/, ' '))

        @category.update
      end
    end

    context 'given invalid input' do
      it 'should return false when category_name is nil' do
        expect(@category_invalid.update).to eq(false)
      end
    end
  end

  describe '#delete' do
    context 'given valid input' do
      it 'should delete the category' do
        expect(@dummy_database).to receive(:query).with("
            delete from categories
            where id='#{@category.id}';
          ".gsub(/\s+/, ' '))
        expect(@dummy_database).to receive(:query).with("
            update item_categories
            set category_id=null
            where category_id='#{@category.id}'
          ".gsub(/\s+/, ' '))

        @category.delete
      end
    end

    context 'given invalid input' do
      it 'should return false when category_name is nil' do
        expect(@category_invalid.delete).to eq(false)
      end
    end
  end
end
