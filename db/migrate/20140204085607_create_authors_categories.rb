class CreateAuthorsCategories < ActiveRecord::Migration
  def change
    create_table :authors_categories do |t|
      t.belongs_to :author
      t.belongs_to :category

      t.timestamps
    end
  end
end
