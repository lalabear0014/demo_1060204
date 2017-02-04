class EventsController < ApplicationController
	# 注意！！！只有 index 的 @events —> 有加s
	# 其他的 action 的 @event 都沒有

	# GET /events/index
	# GET /events
	def index
		@events = Event.all
	end

	# GET /events/new
	def new
		@event = Event.new
	end

	# POST /events/create
	def create
		@event = Event.new( event_params )
		@event.save

		# 告訴瀏覽器 HTTP code: 303
		redirect_to :action => :index
	end

	private

	def event_params
		params.require(:event).permit(:name, :description)
	end


	
end
