class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :manuals
  has_many :procedures
  has_many :comments
  has_many :releases
  has_many :likes
  has_many :like_manuals, through: :likes, source: :manual

  validates :nickname, presence: true
end
