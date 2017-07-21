class AddPositionToProfiles < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :education, :string
    add_column :profiles, :position, :string
    add_column :profiles, :address, :text
    add_column :profiles, :phone, :string
    add_column :profiles, :publications, :text
    add_column :profiles, :details, :text
  end
end
