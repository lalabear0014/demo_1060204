class Admin::EventsController < ApplicationController

	before_action :authenticate_user!

	before_action :check_admin

	layout "admin"

	def index
		@events = Event.all
	end

	protected

    def check_admin
    	unless current_user.admin?
    		# flash[:alert] = "No permission!!!"
       		# redirect_to root_path
       		# return
       		raise ActiveRecord::RecordNotFind	# error 404
    	end
    end
    
end
