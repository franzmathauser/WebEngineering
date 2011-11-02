class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  private
    def loggedon
      if !signed_in? then
        redirect_to :root
      end
    end

end
