require_relative '../config'


class CreateStudents < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.integer   :id
      t.string    :first_name
      t.string    :last_name
      t.string    :gender
      t.string    :email
      t.string    :phone
      # t.datetime  :created_at
      # t.datetime  :updated_at 
    end
  end
end
