class Procedure < ApplicationRecord
  belongs_to :manual
  belongs_to :user
  has_one_attached :image

  validates :title, presence: true
end
