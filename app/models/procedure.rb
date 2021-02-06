class Procedure < ApplicationRecord
  belongs_to :manual
  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy

  validates :title, presence: true

  def image_attach_local(procedure, decoded_url, filename)
    File.open("#{Rails.root}/tmp/images/#{filename}", "wb") do |f|
      f.write(decoded_url)
    end
    procedure.image.attach(io: File.open("#{Rails.root}/tmp/images/#{filename}"), filename: filename)
    FileUtils.rm("#{Rails.root}/tmp/images/#{filename}")
  end

  def image_attach_production(procedure, decoded_url, filename)
    File.open("/tmp/#{filename}", "wb") do |f|
      f.write(decoded_url)
    end
    procedure.image.attach(io: File.open("/tmp/#{filename}"), filename: filename)
    FileUtils.rm("/tmp/#{filename}")
  end
end
