class UsersGroupsController < ApplicationController

	before_action :authorize
	before_action :find_users_group

	def accept_invitation
		@users_group.update_attribute(:status, "accept")
	end

	def reject_invitation
		@users_group.destroy!
	end

	private
	def find_users_group
		@users_group = UsersGroup.where(user_id: params[:id] , group_id: params[:group_id]).first
	end

end
