class AddColumnToGame < ActiveRecord::Migration[5.2]
  def change
  	add_column :games, :rating, :integer
  	add_column :games, :difficulty, :integer
  end
end
