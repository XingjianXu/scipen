class Profile < ApplicationRecord

  belongs_to :user

  def label
    if first_name.present? || last_name.present?
      "#{first_name} #{last_name}"
    else
      user.email
    end
  end

end
