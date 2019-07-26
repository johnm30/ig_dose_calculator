class DiseaseDescription < ApplicationRecord
  belongs_to :disease
  validates :description, presence: true, length: { maximum: 2500 }
  validates :name,  presence: true, length: { maximum: 50 }, uniqueness: true

  # Need to check below, wanting alphabetical order
  # Might even do this when going though diseases, as the ID will just depend on
  # when I entered them into database
  default_scope { order( :name)}

  # Search by description
  def self.search(search_string)
    if search_string.blank?  # blank? covers both nil and empty string
      all
    else
      # LIKE gives different behaviour in SQL (development) and postgresql (production on
      #  Heroku). In SQL can type just part of a word and case insensitive, in
      # postgresql need a whole word and case sensitive
      # To make postgresql case insensitive use ILIKE - won;t work in sql
      if Rails.env.production?
        where('description ILIKE ?', "%#{search_string}%")
      else
        where('description LIKE ?', "%#{search_string}%")
      end
    end
  end
end
