class ChangeColumnForGame < ActiveRecord::Migration[5.2]
  def change
  	change_column :games, :rating, :float
  	change_column :games, :difficulty, :float
  end
end
