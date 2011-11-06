class Audiofile < ActiveRecord::Base
   # Root directory of the audio public/audios
   AUDIO_STORE = File.join RAILS_ROOT, 'app', 'assets', 'audio'

   # Invoke save_audio method when save is completed
   after_save :save_audio

   # "f.file_field :load_audio_file" in the view triggers Rails to invoke this method
   # This method only store the information
   # The file saving is done in after_save
   def load_audio_file=(data)
     # Record the filename
     self.filename = data.original_filename
     # Store the data for later use
     @audio_data = data
   end

   # Called when save is completed
   def save_audio
     if @audio_data
       # Write the data out to a file
       name = File.join AUDIO_STORE, self.filename
       File.open(name, 'wb') do |f|
         f.write(@audio_data.read)
       end
       @audio_data = nil
     end
   end
end
