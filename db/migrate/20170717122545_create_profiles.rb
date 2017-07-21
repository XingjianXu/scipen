class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.integer :user_id, index: true, unique: true
      t.timestamps
    end
  end
end
