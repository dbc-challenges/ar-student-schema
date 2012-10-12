require 'rspec'
require 'date'
require_relative '../app/migrate'
require_relative '../app/student'


describe Student, "#name and #age" do

  before(:all) do
    Migrate::recreate
    @student = Student.new
    @student.assign_attributes(
      :first_name => "Happy",
      :last_name => "Gilmore",
      :gender => 'male',
      :birthday => Date.new(1970,9,1)
    )
  end

  it "should have name and age methods" do
    [:name, :age].each { |mthd| @student.should respond_to mthd }
  end

  it "should concatenate first and last name" do
    @student.name.should == "Happy Gilmore"
  end

  it "should be the right age" do
    now = Date.today
    age = now.year - @student.birthday.year - ((now.month > @student.birthday.month || (now.month == @student.birthday.month && now.day >= @student.birthday.day)) ? 0 : 1)
    @student.age.should == age
  end

end

describe Student, "validations" do

  # Email addresses must contain at least one @ character and one . character, with at least one character before the @, one character between the @ and first ., and at least two characters after the final ..
  # Students must be at least 5 years old.
  # Phone numbers must contain at least 10 digits, excluding non-numeric characters.

  before(:all) do
    Migrate::recreate
  end

  before(:each) do
    @student = Student.new
    @student.assign_attributes(
      :first_name => "Kreay",
      :last_name => "Shawn",
      :birthday => Date.new(1989,9,24),
      :gender => 'female',
      :email => 'kreayshawn@oaklandrappers.net',
      :phone => '(510) 555-1212 x4567'
    )
  end

  it "should accept valid info" do
    @student.should be_valid
  end

  it "shouldn't accept invalid emails" do
    ["XYZ!bitnet", "@.", "a@b.c"].each do |address|
      @student.assign_attributes(:email => address)
      @student.should_not be_valid
    end
  end

  it "should accept valid emails" do
    ["joe@example.com", "info@bbc.co.uk", "bugs@devbootcamp.com"].each do |address|
      @student.assign_attributes(:email => address)
      @student.should be_valid
    end
  end

  it "shouldn't accept toddlers" do
    @student.assign_attributes(:birthday => Date.today - 3.years)
    @student.should_not be_valid
  end

  it "shouldn't accept invalid phone numbers" do
    @student.assign_attributes(:phone => '347-8901')
    @student.should_not be_valid
  end

  it "shouldn't allow two students with the same email" do
    another_student = Student.create!(
      :birthday => @student.birthday,
      :email => @student.email,
      :phone => @student.phone
    )
    @student.should_not be_valid
  end

end
