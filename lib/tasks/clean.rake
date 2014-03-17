namespace :clean do
  desc "Delete uploads without files from db"
  task :upload_db => :environment do
    UploadedImage.all.each do |u|
      u.destroy unless File.exist?(u.thumb) && File.exist?(u.image)
    end
  end

  # desc "Delete files from uploads that are not in db"
  # task :upload_files => :environment do
  #   UploadedImage.all.each do |u|
  #     u.destroy unless File.exist?(u.thumb) && File.exist?(u.image)
  #   end
  # end
end