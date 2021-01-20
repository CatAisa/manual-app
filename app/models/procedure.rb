class Procedure < ApplicationRecord
  belongs_to :manual
  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy

  validates :title, presence: true
end
