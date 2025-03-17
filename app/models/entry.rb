class Entry < ApplicationRecord
  belongs_to :user
  belongs_to :place

  # ✅ Enable file uploads using Active Storage
  has_one_attached :uploaded_image
end
