class Trial < ApplicationRecord
  belongs_to :user

  default_scope -> { order(created_at: :desc) }

  serialize :attacks, Hash
  serialize :table, Hash
end
