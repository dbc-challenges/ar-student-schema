require 'rake'
require 'rspec'
# Dir[File.dirname(__FILE__) + '/../db/migrate/*.rb'].each do |f|
#   require_relative f.chomp(File.extname(f))
# end


describe "db:migrate" do
  before(:all) do
    Rake.application = Rake::Application.new
    Rake.application.add_import File.dirname(__FILE__) + "/../Rakefile"
    Rake.application.load_imports
  end

  it "should have a Students table" do
    Rake::Task["db:migrate"].invoke
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


describe "db:migrate VERSION=-1" do
  before(:all) do
    Rake.application = Rake::Application.new
    Rake.application.add_import File.dirname(__FILE__) + "/../Rakefile"
    Rake.application.load_imports
    ENV['VERSION'] = '-1'
  end

  it "shouldn't have a Students table" do
    Rake::Task["db:migrate"].invoke
    ActiveRecord::Base.connection.table_exists?(:students).should be_false
  end
end
