require_relative '../../config/env/development'
require_relative '../../app/models/category'

describe Category do
  before(:each) do
    @category = Category.new({
      category_id: 6,
      category_name: 'candy'
    })

    @dummy_database = double
    allow(Mysql2::Client).to receive(:new).and_return(@dummy_database)
  end

  describe "#save" do
    context "given valid input" do
      it "should save to database" do
        expect(@dummy_database).to receive(:query).with("
            insert into categories (name) values ('#{@category.name}');
          ".gsub(/\s+/, " "))
        
          @category.save
      end
    end
  end

  describe "#update" do
    context "given valid input" do
      it "should update the category" do
        expect(@dummy_database).to receive(:query).with("
            update categories
            set name='#{@category.name}'
            where id='#{@category.id}';
          ".gsub(/\s+/, " "))
  
          @category.update
      end
    end
  end
end
