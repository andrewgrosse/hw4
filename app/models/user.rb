class User < ApplicationRecord
  has_secure_password
  has_many :places
  has_many :entries

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
end
