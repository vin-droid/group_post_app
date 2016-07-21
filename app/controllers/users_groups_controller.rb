class UsersGroupsController < ApplicationController

	before_action :authorize
	before_action :find_users_group

	def accept_invitation
		@users_group.update_attribute(:status, "accepted")
		redirect_to '/'
	end

	def reject_invitation
		@users_group.destroy!
		redirect_to '/'
	end

	private
	def find_users_group
		@users_group = UsersGroup.find(params[:users_group_id])
	end

end
