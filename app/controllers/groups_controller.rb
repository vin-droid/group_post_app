class GroupsController < ApplicationController
    # protect_from_forgery except: :index
	before_action :find_group , only:[:destroy,:show]
	before_action :find_params, only:[:create]
	before_action :authorize
	

	def create
		@group = @current_user.groups.create(find_params)
		users_ids = params[:user_ids]
		if @group.save!
			users_ids.each do |user_id|
				UsersGroup.create! user_id: user_id, group_id: @group.id 
			end 
			UsersGroup.find_by(user_id: @current_user.id, group_id: @group.id).update_attribute(:status, "accepted")
			redirect_to root_path
		else
			render :new
		end
	end

	def new
		@group = @current_user.groups.new
	end

	def destroy
		@group.destroy
		redirect_to root_path
	end

	def show
	    redirect_to	group_posts_path(@group.id)
	end

	def index
		group_ids =  UsersGroup.where(user_id: @current_user.id,status: "accepted").pluck(:group_id)
		@groups = Group.where(id: group_ids)
	end

	def update
		@group.update(find_params)
		redirect_to root_path
	end

	private
	def find_params
		params[:group][:group_creator] = current_user.username
		params.require(:group).permit(:name ,:body,:users_ids,:group_creator)
	end
end
