class OriginalString < ApplicationRecord
  validates :value, presence: true, length: { maximum: 1000 }
end
