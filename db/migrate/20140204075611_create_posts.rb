class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :message
      t.integer :likes, default: 0
      t.string :pic_url
      t.string :from
      t.integer :author_id

      t.timestamps
    end
    add_index :posts, :author_id
  end
end
