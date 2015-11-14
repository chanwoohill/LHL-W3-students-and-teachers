class AddAssociations < ActiveRecord::Migration
  
  def change
    change_table :students do |t|
      t.references :teacher
    end
  end

end

