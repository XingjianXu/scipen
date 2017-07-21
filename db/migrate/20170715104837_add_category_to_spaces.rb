class AddCategoryToSpaces < ActiveRecord::Migration[5.1]
  def change
    add_column :spaces, :category_id, :integer, index: true
  end
end
