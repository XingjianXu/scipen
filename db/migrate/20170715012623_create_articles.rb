class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.text :title, index: true
      t.text :slug, index: true, unique: true
      t.text :content
      t.text :source
      t.integer :space_id, index: true

      t.timestamps
    end
  end
end
