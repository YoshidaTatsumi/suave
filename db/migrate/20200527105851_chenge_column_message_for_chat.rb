class ChengeColumnMessageForChat < ActiveRecord::Migration[5.2]
  def change
  	change_column :chats, :message, :text
  end
end
