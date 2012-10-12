require 'rspec'
require_relative '../app/migrate'


describe Migrate, "#recreate" do

  it "should have a Students table" do
    Migrate::recreate
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

describe Migrate, "#drop" do

  it "shouldn't have a Students table" do
    Migrate::drop
    ActiveRecord::Base.connection.table_exists?(:students).should be_false
  end

end
