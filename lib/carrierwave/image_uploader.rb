require 'carrierwave/orm/activerecord'

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/images/pages/"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  process :resize_to_fit => [600, 500]

  version :thumb do
    process :resize_to_fill => [100,74] # размер превью
  end

  storage :file
end