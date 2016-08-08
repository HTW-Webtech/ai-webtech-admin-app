class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.text :body
      t.references :app

      t.timestamps null: false
    end
    add_foreign_key :feedbacks, :apps
  end
end
