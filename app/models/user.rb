class User < ApplicationRecord
  belongs_to :city
  has_many :gossips
  has_many :likes
  has_secure_password


  validates :first_name,
    presence: true

  validates :last_name,
    presence: true

  validates :email,
    presence: true,
    uniqueness: true

  validates :age,
    presence: true,
    numericality: { greater_than_or_equal_to: 18 }

  validates :password,
    presence: true,
    length: { in: 6..20 }

end
