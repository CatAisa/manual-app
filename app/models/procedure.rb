class Procedure < ApplicationRecord
  belongs_to :manual
  has_one_attached :image
end
