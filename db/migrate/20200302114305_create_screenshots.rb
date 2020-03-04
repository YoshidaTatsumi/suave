class CreateScreenshots < ActiveRecord::Migration[5.2]
  def change
    create_table :screenshots do |t|
    	t.integer :game_id
    	t.string :image_id

      t.timestamps
    end
  end
end
