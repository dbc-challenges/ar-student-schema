require 'rspec'
Dir[File.dirname(__FILE__) + '/../db/migrate/*.rb'].each do |f|
  require_relative f.chomp(File.extname(f))
end

describe CreateStudents, "#migrate(:up)" do

  it "should have a Students table" do
    CreateStudents.new.migrate(:up)
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


describe CreateStudents, "#migrate(:down)" do

  it "shouldn't have a Students table" do
    CreateStudents.new.migrate(:down)
    ActiveRecord::Base.connection.table_exists?(:students).should be_false
  end

end
