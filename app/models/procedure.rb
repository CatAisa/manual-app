class Procedure < ApplicationRecord
  belongs_to :manual
  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { maximum: 30 }
  validates :description, length: { maximum: 400 }

  def image_attach(converted_url)
    decoded_url = Base64.decode64(converted_url)
    filename = Time.zone.now.to_s + '.png'

    if Rails.env == 'development'
      # Local environment
      File.open("#{Rails.root}/tmp/images/#{filename}", 'wb') do |f|
        f.write(decoded_url)
      end
      image.attach(io: File.open("#{Rails.root}/tmp/images/#{filename}"), filename: filename)
      FileUtils.rm("#{Rails.root}/tmp/images/#{filename}")
    elsif Rails.env == 'production'
      # Production environment
      File.open("/tmp/#{filename}", 'wb') do |f|
        f.write(decoded_url)
      end
      image.attach(io: File.open("/tmp/#{filename}"), filename: filename)
      FileUtils.rm("/tmp/#{filename}")
    end
  end
end
