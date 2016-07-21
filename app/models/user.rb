class User < ApplicationRecord
has_secure_password
has_many :users_groups ,class_name: "UsersGroup"
has_many :groups, through: :users_groups 
has_many :group_invitations, -> { where status: 'pending'}, class_name: 'UsersGroup'
has_many :posts

  before_save { self.email = email.downcase }
  validates :username, presence: true, length:{ minimum: 6 }, :uniqueness => {message:"username already has been taken"}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false ,message:"email already has been taken" }
  validates :password, presence: true, confirmation: true,  length: { minimum: 6 } 

def is_group_creator_of group
	(self.username == group.group_creator)? true : false
end

end
