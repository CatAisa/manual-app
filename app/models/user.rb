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
  has_many :reviews

  validates :nickname, presence: true, format: { with: /\A[a-zA-Z0-9]+\z/, message: 'は半角英数10文字以内で入力してください' },
                       length: { maximum: 10 }
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: 'は半角英字と半角数字の両方を含んでください' },
                       length: { minimum: 8 }

  def already_liked?(manual)
    likes.exists?(manual_id: manual.id)
  end
end
