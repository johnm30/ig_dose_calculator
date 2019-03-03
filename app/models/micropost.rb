class Micropost < ApplicationRecord
  belongs_to :user

  # Order according to creates_at in descending order
  # The -> is a stubby lambda which is a function created without a name and it
  # takes in a block and converts this code into a nameless method. The call method
  # subsequently runs the code as if calling the method.
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 1000 }

  # This is a custom rather than built invalidation so singular and need a
  # private method below
  validate  :picture_size

  private

    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
