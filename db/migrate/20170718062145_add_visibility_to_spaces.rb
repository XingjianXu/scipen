class AddVisibilityToSpaces < ActiveRecord::Migration[5.1]
  def change
    add_column :spaces, :visibility, :integer, index: true, default: 0
  end
end
