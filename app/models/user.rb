class User < ApplicationRecord
has_secure_password
has_many :users_group
has_many :groups  ,through: :users_group 
has_many :group_invitations ,-> { where status: 'pending'}, class_name: 'UsersGroup'

def is_group_creator_of group
	(self.username == group.group_creator)? true : false
end

end
