class User < ApplicationRecord
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :profile

  enum role: [:admin]

  before_save :create_profile

  private

  def create_profile
    self.profile = Profile.create unless self.profile
  end

end
