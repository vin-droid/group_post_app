class User < ApplicationRecord

has_many :users_group
has_many :groups  ,through: :users_group 


end
