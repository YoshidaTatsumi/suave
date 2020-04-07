class AddColumnToChat < ActiveRecord::Migration[5.2]
  def change
  	add_column :chats, :admin_id, :integer
  end
end
