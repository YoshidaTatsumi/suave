class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
    	t.integer :user_id
    	t.string :title
    	t.text :content
    	t.text :reply_content
    	t.boolean :status, default: false, null: false

      t.timestamps
    end
  end
end
