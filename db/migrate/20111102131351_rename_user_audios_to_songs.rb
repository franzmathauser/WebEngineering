class RenameUserAudiosToSongs < ActiveRecord::Migration
  def change
    rename_table :user_audios, :songs
  end
end
