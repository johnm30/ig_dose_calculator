class Trial < ApplicationRecord
  belongs_to :user

  serialize :attacks, Hash
  serialize :table, Hash
end
