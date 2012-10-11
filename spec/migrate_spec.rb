require_relative '../app/migrate'


describe Schema, "#recreate" do

  it "should have a Students table" do
    Schema::recreate
    ActiveRecord::Base.connection.table_exists?(:students).should be_true
  end

  it "should have the right columns and types" do
    expected = {
      :integer => ["id"],
      :string => ["first_name", "last_name", "gender", "email", "phone"],
      :date => ["birthday"]
    }

    ActiveRecord::Base.connection.columns(:students).each do |col|
      expected[col.type].include?(col.name).should be_true
    end
  end

end

describe Schema, "#drop" do

  it "shouldn't have a Students table" do
    Schema::drop
    ActiveRecord::Base.connection.table_exists?(:students).should be_false
  end

end
