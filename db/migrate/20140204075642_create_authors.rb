class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :profile
      t.integer :category_id

      t.timestamps
    end
    add_index :authors, :profile, :unique => true
  end
end
