class AddIndexesToPages < ActiveRecord::Migration
  def self.up
    add_index :pages, :slug, unique: true
    add_index :pages, :parent_id
  end

  def self.down
    remove_index :pages, :slug
    remove_index :pages, :parent_id
  end
end
