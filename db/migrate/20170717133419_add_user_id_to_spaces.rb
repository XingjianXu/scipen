class AddUserIdToSpaces < ActiveRecord::Migration[5.1]
  def change
    add_column :spaces, :user_id, :integer, index: true
  end
end
