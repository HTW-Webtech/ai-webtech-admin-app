class AddExternalHostingToApps < ActiveRecord::Migration
  def change
    add_column :apps, :external_hosting, :boolean, default: false
    add_column :apps, :external_url, :string
  end
end
