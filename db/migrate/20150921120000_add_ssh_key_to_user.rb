class AddSshKeyToUser < ActiveRecord::Migration
  def change
    add_column :users, :ssh_key, :string, default: '', null: false
  end
end
