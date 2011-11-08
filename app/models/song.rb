class Song < ActiveRecord::Base
  belongs_to :user
  belongs_to :audio
  has_many :song_comments, :dependent => :delete_all
  
  validates(:name, :presence => true)
end
