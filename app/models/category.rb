class Category < ApplicationRecord
  has_many :spaces, -> {order(:name)}
end
