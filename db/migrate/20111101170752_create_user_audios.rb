class CreateUserAudios < ActiveRecord::Migration
  def change
    create_table :user_audios do |t|
      t.string :name
      t.string :title
      t.string :artist
      t.string :album
      t.integer :duration

      t.references :audio
      t.references :user

      t.timestamps
    end

  end
end
