class UsersGroupsController < ApplicationController

before_action :authorize
before_action :find_users_group


def accept_invitation
	@usse
end

def reject_invitation
	
end



private
def find_users_group
	@users_group = UsersGroup.find(params[])
end

end
