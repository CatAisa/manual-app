class Review < ApplicationRecord
  belongs_to :user
  belongs_to :manual

  validates :content, presence: true, length: { maximum: 200 }
end
