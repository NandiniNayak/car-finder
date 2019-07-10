class Profile < ApplicationRecord
  validates :first_name, :last_name, :phone_number, :user_name, presence: true

  belongs_to :user
  has_one :seller
  has_one :buyer
end
