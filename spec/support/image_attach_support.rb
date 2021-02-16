module ImageAttachSupport
  def manual_image_attach
    image_path = Rails.root.join('public/images/test_image.jpg')
    attach_file('manual[image]', image_path, make_visible: true)
  end
end