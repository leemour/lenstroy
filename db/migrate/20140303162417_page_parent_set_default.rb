class PageParentSetDefault < ActiveRecord::Migration
  def self.up
    change_column :pages, :parent_id, :integer, :default => 0
    Page.all.each { |p| p.update_attribute(:parent_id, 0) }
  end

  def self.down
    change_column :pages, :parent_id, :integer
  end
end
