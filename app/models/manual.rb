class Manual < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :procedures, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :release, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category

  with_options presence: true do
    validates :title
    validates :category_id, numericality: { other_than: 0, message: 'is invalid. Select status' }
  end
end
