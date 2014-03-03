class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :slug
      t.string :title
      t.text   :content
      t.string :excerpt
      t.string :seo_title
      t.string :seo_desc
      t.string :seo_keys
      t.integer :parent_id
      t.string :status
      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
