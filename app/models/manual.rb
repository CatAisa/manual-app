class Manual < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :procedures, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :release, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
  has_many :reviews

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category

  with_options presence: true do
    validates :title
    validates :category_id, numericality: { other_than: 0, message: 'is invalid. Select status' }
  end

  def image_attach_local(manual, decoded_url, filename)
    File.open("#{Rails.root}/tmp/images/#{filename}", "wb") do |f|
      f.write(decoded_url)
    end
    manual.image.attach(io: File.open("#{Rails.root}/tmp/images/#{filename}"), filename: filename)
    FileUtils.rm("#{Rails.root}/tmp/images/#{filename}")
  end

  def image_attach_production(manual, decoded_url, filename)
    File.open("/tmp/#{filename}", "wb") do |f|
      f.write(decoded_url)
    end
    manual.image.attach(io: File.open("/tmp/#{filename}"), filename: filename)
    FileUtils.rm("/tmp/#{filename}")
  end
end
