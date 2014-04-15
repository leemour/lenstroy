require 'carrierwave/orm/activerecord'

class ProjectUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/images/projects/#{model.slug}/"
  end

  def extension_white_list
    %w(jpg jpeg png)
  end

  process :resize_to_fit => [960, 960]

  version :thumb do
    process :resize_to_fill => [160, 120] # размер превью
  end

  storage :file
end