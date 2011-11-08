class AddMoreMp3Id3FieldsToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :year, :integer
    add_column :songs, :tracknum, :integer
  end
end
