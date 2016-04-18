class DropEnvVars < ActiveRecord::Migration
  def change
    remove_column :apps, :env_vars
  end
end
