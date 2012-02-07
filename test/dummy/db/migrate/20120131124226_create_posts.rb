class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.date :published_at
      t.boolean :active
      t.boolean :version_state
      t.text :version_draft

      t.timestamps
    end
  end
end

