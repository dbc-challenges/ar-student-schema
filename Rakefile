require 'rake'
require 'rspec/core/rake_task'

desc "create the database"
task "db:create" do
  touch 'db/ar-students.sqlite3'
end

desc "drop the database"
task "db:drop" do
  rm_f 'db/ar-students.sqlite3'
end

desc "Run the specs"
RSpec::Core::RakeTask.new(:specs)

task :default  => :specs
