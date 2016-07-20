class GroupsController < ApplicationController

before_action :find_group , only:[:destroy,:show]
before_acrion :find_params, only:[:create,:show]
before_acrion :authorize


def create
	@group = current_user.groups.create(find_params)
		if @group.save 
			redirect_to root_path
		else
			render 'new'
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
         params.require(:group).permit(:title ,:body)
      end
end
