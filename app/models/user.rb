class User < ApplicationRecord
  has_secure_password
  has_many :places  # A user can have multiple places
end
