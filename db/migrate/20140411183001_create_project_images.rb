class CreateProjectImages < ActiveRecord::Migration
  def self.up
    create_table :project_images do |t|
      t.references :project
      t.string :file
      t.timestamps
      t.index :project_id
    end
  end

  def self.down
    drop_table :project_images
  end
end
