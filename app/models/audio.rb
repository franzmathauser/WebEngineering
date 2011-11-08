class Audio < ActiveRecord::Base
  has_many :songs, :dependent => :delete_all
end
