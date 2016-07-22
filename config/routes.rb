Rails.application.routes.draw do
	root 'groups#index'
	resources :users 
	delete "logout" => 'session#destroy'
	get  "login"    => 'session#new'
	post "login"    => 'session#create'
	resources :groups  do 
		member do 
			get "remove_user/:user_id" => 'groups#remove_user', as: 'remove_user'
 			get "add_user/:user_id" => 'groups#add_user', as: 'add_user'
			get 'group_details'
		end
		resources :posts do 
			resources :comments do 
			end 
		end
	end
		get 'accept_invitation/:users_group_id' => 'users_groups#accept_invitation', as: 'accept_invitation' 
		get 'reject_invitation/:users_group_id' => 'users_groups#accept_invitation', as: 'reject_invitation'
end

