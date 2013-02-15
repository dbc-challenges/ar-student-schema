require_relative '../../db/config'

class Student < ActiveRecord::Base 

  validates :email, :uniqueness => true
  validates :email, :format => { :with => /\S+[@]\w+[.]\w{2,}/, :message => "Invalid email" }
  validates :age, :numericality => {:greater_than => 4}
  validates :sanitized_number, :numericality => {:greater_than => 9} 

  # Does it matter if age and sanitized_number are instance variables (@age and @sanitized_number)?


  def name  
    name = "#{first_name} #{last_name}"
  end

  def age
    now.year - birthday.year  - ((now.month > birthday.month || (now.month == birthday.month && now.day >= birthday.day)) ? 0 : 1)
  end 

  def sanitized_number
    phone.gsub(/\D/, '').length
  end
end 
 

