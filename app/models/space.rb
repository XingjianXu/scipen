class Space < ApplicationRecord
  has_many :articles, -> { order('created_at') }

  belongs_to :category

  belongs_to :user

  enum visibility: {personal: 0, trusted: 1, unrestricted: 2}

  default_scope -> {order(:name)}

end
