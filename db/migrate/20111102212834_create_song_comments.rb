class CreateSongComments < ActiveRecord::Migration
  def change
    create_table :song_comments do |t|
      t.integer :from_duration
      t.integer :to_duration
      t.text :body
      t.references :user
      t.references :song

      t.timestamps
    end
    add_index :song_comments, :user_id
    add_index :song_comments, :song_id
  end
end
