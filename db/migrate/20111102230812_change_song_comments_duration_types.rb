class ChangeSongCommentsDurationTypes < ActiveRecord::Migration
  def up
    change_column :song_comments, :from_duration, :float
    change_column :song_comments, :to_duration, :float
  end

  def down
    change_column :song_comments, :from_duration, :integer
    change_column :song_comments, :to_duration, :integer
  end
end
