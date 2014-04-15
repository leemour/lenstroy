class UploadedImage < ActiveRecord::Base
  UPLOAD_PATH = '/uploads/images/'

  mount_uploader :file, ImageUploader

  def self.store(file)
    filename     = file[:filename]
    upload       = UploadedImage.new
    upload.file  = file
    upload.image = UPLOAD_PATH + filename
    upload.thumb = UPLOAD_PATH + "thumb_#{filename}"
    upload.save
    { filelink: upload.image }
  end

  def self.imagelist
    uploads = UploadedImage.all
    uploads.map {|upload| {thumb: upload.thumb, image: upload.image} }
  end
end