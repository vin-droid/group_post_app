class GroupsController < ApplicationController

	before_action :find_group , only:[:destroy,:show]
	before_action :find_params, only:[:create]
	before_action :authorize

	def create
		@group = current_user.groups.create(find_params)
		if @group.save!
			users_ids.each do |user_id|
				UsersGroup.create! user_id: user_id, group_id: self.id 
			end 
			UsersGroup.create! user_id: params[:group][:group_creator], group_id:  @group.id
			redirect_to root_path
		else
			render :new
		end
	end

	def new
		@group = current_user.groups.new
	end

	def destroy
		@group.destroy
		redirect_to root_path
	end

	def show
	    redirect_to	group_posts_path(@group.id)
	end

	def index
		@groups = Group.all.includes(:users,:posts)
	end

	def update
		@group.update(find_params)
		redirect_to root_path
	end

	private
	def find_params
		params[:group][:group_creator] = current_user.id
		params.require(:group).permit(:title ,:body,:users_ids,:group_creator)
	end
end
