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
		if @event.save
			flash[:notice] = "新增成功"

			redirect_to :action => :index	# 告訴瀏覽器 HTTP code: 303
		else
			render :action => :new	# new.html.erb
		end
	end

	# GET /events/edit/:id
	def edit
		
	end

	# POST /events/update/:id
	def update
		if @event.update( event_params )
			flash[:notice] = "編輯成功"
			redirect_to :action => :show, :id => @event
		else
			# 用 redirect_to 會重新整理頁面，原本要輸入的資料會不見
			# 用 render 可保留頁面
			# redirect_to :action => :edit, :id => @event
			render :action => :edit	# edit.html.erb
		end
	end

	# GET /events/destroy/:id
	def destroy
		@event.destroy
		flash[:alert] = "刪除成功"

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
