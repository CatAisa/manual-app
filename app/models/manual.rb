class Manual < ApplicationRecord
  belongs_to :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category_id

  with_options presence: true do
    validates :title
    validates :category_id, numericality: {other_than: 0, message: "is invalid. Select status"}
  end
end
