class DataFile < ActiveRecord::Base
  def self.save(upload,name)
#    name =  upload['datafile'].original_filename
#    name = upload[:file_id]

    directory = "app/assets/audio"
    # create the file path
    path = File.join(directory, name)
    # write the file
    File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
    path
  end
end
