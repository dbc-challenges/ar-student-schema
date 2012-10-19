require 'rspec'
require_relative '../db/config'


describe "add timestamps" do
  it "should have the right columns and types" do
    found_created_at = found_updated_at = false
    ActiveRecord::Base.connection.columns(:students).each do |col|
      case col.name
      when "created_at"
        found_created_at = true
        col.type.should == :datetime
      when "updated_at"
        found_updated_at = true
        col.type.should == :datetime
      end
    end
    (found_created_at && found_updated_at).should be_true
  end
end
