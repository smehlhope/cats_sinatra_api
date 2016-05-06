class CreateCatModel < ActiveRecord::Migration

  def up
  	create_table :cats do |t|
  		t.string :name
  		t.integer :age
  	end
  end

  def down
  	drop_table :cats
  end

end