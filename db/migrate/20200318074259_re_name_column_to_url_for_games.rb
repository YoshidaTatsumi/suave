class ReNameColumnToUrlForGames < ActiveRecord::Migration[5.2]
  def change
  	rename_column :games, :url, :file_name
  end
end
