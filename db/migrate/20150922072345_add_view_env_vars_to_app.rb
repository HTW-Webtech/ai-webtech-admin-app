class AddViewEnvVarsToApp < ActiveRecord::Migration
  def change
    add_column :apps, :env_vars_view, :string, null: false, default: ''
  end
end
