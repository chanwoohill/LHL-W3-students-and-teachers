class CreateStudents < ActiveRecord::Migration
  
  def change
    # Add code to create the table here
    # HINT: check out ActiveRecord::Migration.create_table
    create_table :students do |t|
      t.string  :first_name
      t.string  :last_name
      t.string  :gender, limit: 1
      t.date  :birthday
      t.string  :email
      t.string  :phone
      t.timestamps null: false
    end
  end

end

