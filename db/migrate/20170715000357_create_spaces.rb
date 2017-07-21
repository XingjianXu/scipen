class CreateSpaces < ActiveRecord::Migration[5.1]
  def change
    create_table :spaces do |t|
      t.string :name, index: true
      t.string :key, index: true, unique: true
      t.text :description

      t.timestamps
    end
  end
end
