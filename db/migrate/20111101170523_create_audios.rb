class CreateAudios < ActiveRecord::Migration
  def change
    create_table :audios do |t|
      t.string :filehash
      t.boolean :converted
      t.boolean :imageprocessed

      t.timestamps
    end
  end
end
