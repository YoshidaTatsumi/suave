class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
    	t.integer :user_id
    	t.string :title
    	t.text :introduction
    	t.text :url

      t.timestamps
    end
  end
end
