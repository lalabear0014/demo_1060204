class EventsController < ApplicationController
	
	before_action :set_event, :only => [:show, :edit, :update, :destroy]

	# 注意！！！只有 index 的 @events —> 有加s
	# 其他的 action 的 @event 都沒有

	# GET /events/index
	# GET /events
	def index
		@events = Event.all
	end

	# GET /events/show/:id
	def show
		@page_title = @event.name
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

	# GET /events/edit/:id
	def edit
		
	end

	# POST /events/update/:id
	def update
		@event.update( event_params )

		redirect_to :action => :show, :id => @event
	end

	# GET /events/destroy/:id
	def destroy
		@event.destroy

		redirect_to :action => :index
	end

	private

	def set_event
		@event = Event.find( params[:id] )
	end

	def event_params
		params.require(:event).permit(:name, :description)
	end



end
