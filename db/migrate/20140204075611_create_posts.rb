class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :post_id
      t.text :message
      t.string :picture
      t.datetime :updated_time
      t.integer :author_id
      t.integer :category_id

      t.timestamps
    end
    add_index :posts, :author_id
    add_index :posts, :category_id
    add_index :posts, :post_id, unique: true
  end
end
