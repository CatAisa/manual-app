class Manual < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :procedures, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :release, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
  has_many :reviews, dependent: :destroy

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category

  with_options presence: true do
    validates :title, length: { maximum: 20 }
    validates :category_id, numericality: { other_than: 0, message: 'を選択してください' }
  end
  validates :description, length: { maximum: 160 }

  def image_attach(converted_url)
    decoded_url = Base64.decode64(converted_url)
    filename = Time.zone.now.to_s + '.png'

    if Rails.env == 'development'
      # Local environment
      file_path = "#{Rails.root}/tmp/images/#{filename}"
      image_attach_process(decoded_url, filename, file_path)
    elsif Rails.env == 'production'
      # Production environment
      file_path = "/tmp/#{filename}"
      image_attach_process(decoded_url, filename, file_path)
    end
  end

  def image_attach_process(decoded_url, filename, file_path)
    File.open(file_path, 'wb') do |f|
      f.write(decoded_url)
    end
    image.attach(io: File.open(file_path), filename: filename)
    FileUtils.rm(file_path)
  end
end
