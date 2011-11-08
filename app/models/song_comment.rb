class SongComment < ActiveRecord::Base
  belongs_to :user
  belongs_to :song

  attr_accessible :body, :from_duration, :to_duration, :user_id

  validates(:body, :presence => true,  :length => {:minimum => 1})
  validates(:from_duration, :presence => true)
  validates(:to_duration, :presence => true)
  validates(:user_id, :presence => true)

end
