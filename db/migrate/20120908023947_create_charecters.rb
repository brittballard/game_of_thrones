class CreateCharecters < ActiveRecord::Migration
  def change
    create_table :charecters do |t|
      t.string :first_name
      t.string :last_name
      t.integer :mother_id
      t.integer :father_id
      t.references :house

      t.timestamps
    end
  end
end
