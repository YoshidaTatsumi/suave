class AddIntroductionToRooms < ActiveRecord::Migration[5.2]
  def change
  	add_column :rooms, :introduction, :string
  end
end
