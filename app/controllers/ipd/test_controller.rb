class Ipd::TestController < ApplicationController
   respond_to :js, :json, :html
   def index
      Rails.logger.debug "----Out #{params}"
      render :nothing => true
   end

end
