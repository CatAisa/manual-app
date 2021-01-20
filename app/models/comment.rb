class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :manual
  belongs_to :procedure

  validates :content, presence: true
end
