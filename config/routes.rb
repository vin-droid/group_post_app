Rails.application.routes.draw do
	root 'groups#index'
	resources :users 
	delete "logout" => 'session#destroy'
	get  "login"    => 'session#new'
	post "login"    => 'session#create'
	resources :groups  do 
		member do 
		end
		resources :posts do 
			resources :comments do 
			end 
		end
	end
		get 'accept_invitation/:users_group_id' => 'users_groups#accept_invitation', as: 'accept_invitation' 
		get 'reject_invitation/:users_group_id' => 'users_groups#accept_invitation', as: 'reject_invitation'
end

