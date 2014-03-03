class AddAccountToPage < ActiveRecord::Migration
  def self.up
    change_table :pages do |t|
      t.integer :account_id
    end

    first_account = Account.first
    Page.all.each { |p| p.update_attribute(:account, first_account) }
  end

  def self.down
    change_table :pages do |t|
      t.remove :account_id
    end
  end
end
