require 'rspec'
require_relative '../app/models/student'


describe Student, "internationalized" do

  it "should have a name attribute" do
    student = Student.all.first
    student.name = "John Doe"
    student.save!
    student = Student.find(student.id)
    student.name.should == "John Doe"
  end

  it "should have an address field" do
    student = Student.new
    lambda do
      student.update_attributes(
        :name => "Jane Doe",
        :gender => "female",
        :birthday => Time.new(1973, 01, 01),
        :email => "jane.doe@example.com",
        :phone => "510-555-1212",
        :address => "123 4th St New York NY 10101"
      )
    end.should_not raise_error
  end

  it "should contain correct sample data" do
    Student.where("name = ?", "Karim Bishay").count.should be >= 1
  end

end
