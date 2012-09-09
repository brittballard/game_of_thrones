class AddSexToCharecters < ActiveRecord::Migration
  def change
  	add_column :charecters, :sex, :string, :limit => 1
  end
end
