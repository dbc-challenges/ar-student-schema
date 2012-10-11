require_relative 'config'

# this is where you should use an ActiveRecord migration to 

module Schema

  def self.create
    # HINT: use ActiveRecord::Migration.create_table
  end

  def self.drop
    # HINT: what's the opposite of "CREATE TABLE" in SQL?
  end

  def self.recreate
    self.drop if ActiveRecord::Base.connection.table_exists? :students
    self.create
  end

end
