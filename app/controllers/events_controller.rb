class EventsController < ApplicationController
	
	before_action :authenticate_user!, :except => [:index]

	before_action :set_event, :only => [:show, :dashboard, :edit, :update, :destroy]

	# 注意！！！只有 index & latest 的 @events —> 有加s
	# 其他的 action 的 @event 都沒有

	# GET /events/index
	# GET /events
	def index
		# @events = Event.all 	# 將所有資料撈出來
		prepare_variable_for_index_template
	end

	# GET /events/latest
	def latest
		@events = Event.order("id DESC").limit(3)
	end

	# GET /events/:id
	def show
		@page_title = @event.name
	end

	# GET /events/:id/dashboard
	def dashboard
		
	end

	# GET /events/new
	def new
		@event = Event.new
	end

	# POST /events
	def create
		@event = Event.new( event_params )

		@event.user = current_user
		
		if @event.save
			flash[:notice] = "新增成功"

			redirect_to events_path	# 告訴瀏覽器 HTTP code: 303
		else
			render :action => :new	# new.html.erb
		end
	end

	# GET /events/:id/edit
	def edit
		
	end

	# PATCH /events/:id
	def update
		if @event.update( event_params )
			flash[:notice] = "編輯成功"
			redirect_to event_path(@event)
		else
			# 用 redirect_to 會重新整理頁面，原本要輸入的資料會不見
			# 用 render 可保留頁面
			# redirect_to :action => :edit, :id => @event
			render :action => :edit	# edit.html.erb
		end
	end

	# DELETE /events/:id
	def destroy
		@event.destroy
		flash[:alert] = "刪除成功"

		redirect_to events_path
	end

	# POST /events/bulk_update
	def bulk_update
		ids = Array( params[:ids] )
		events = ids.map{ |i| Event.find_by_id(i) }.compact

		if params[:commit] == "Delete"
			events.each { |e| e.destroy }
		elsif params[:commit] == "Publish"
			events.each { |e| e.update( :status => "published") }
		end

		# redirect_to event_path
		redirect_to :back
	end

	private

	def set_event
		@event = Event.find( params[:id] )
	end

	def event_params
		params.require(:event).permit(:name, :description, :category_id, :status, :group_ids => [])
	end

	def prepare_variable_for_index_template

		if params[:keyword]
			@events = Event.where( [ "name like ?", "%#{params[:keyword]}%" ] )
		else
			@events = Event.all	
		end

		if params[:order]
			sort_by = (params[:order] == 'name') ? 'name' : 'id'
  			@events = @events.order(sort_by)
		end

		@events = @events.page( params[:page] ).per(10)
	end

end
