class User < ApplicationRecord
  has_secure_password  # ✅ Enables password hashing

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
end
