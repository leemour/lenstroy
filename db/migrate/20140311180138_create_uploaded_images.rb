class CreateUploadedImages < ActiveRecord::Migration
  def self.up
    create_table :uploaded_images do |t|
      t.string :file
      t.string :image
      t.string :thumb
    end
  end

  def self.down
    drop_table :uploaded_images
  end
end
