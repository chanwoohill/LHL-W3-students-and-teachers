class AddAssociations < ActiveRecord::Migration
  
  def change
    change_table :students do |t|
      t.references :teacher
    end
  end

  # class AddPartNumberToProducts < ActiveRecord::Migration
  #   def change
  # add_column :products, :part_number, :string

end

