require_relative '../../config/env/development'
require_relative '../../app/models/category'

describe Category do
  describe "#save" do
    context "given valid input" do
      before(:each) do
        @category = Category.new({
          category_id: 6,
          category_name: 'candy'
        })

        @dummy_database = double
        allow(Mysql2::Client).to receive(:new).and_return(@dummy_database)
      end

      it "should save to database" do
        expect(@dummy_database).to receive(:query).with("
            insert into categories (name) values ('#{@category.name}');
          ".gsub(/\s+/, " "))
        
          @category.save
      end
    end
  end
end
