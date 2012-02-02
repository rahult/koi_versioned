class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.date :published_at
      t.boolean :active
      t.boolean :published
      t.text :draft

      t.timestamps
    end
  end
end

