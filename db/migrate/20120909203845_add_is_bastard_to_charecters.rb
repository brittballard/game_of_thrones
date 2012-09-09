class AddIsBastardToCharecters < ActiveRecord::Migration
  def change
  	add_column :charecters, :is_bastard, :boolean
  end
end
