class Manual < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category

  with_options presence: true do
    validates :title
    validates :category_id, numericality: { other_than: 0, message: 'is invalid. Select status' }
  end
end
