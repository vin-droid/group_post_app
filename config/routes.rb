Rails.application.routes.draw do
	root 'groups#index'
	resources :users ,only: [:update, :show,:destroy] do 
		member do 
			get "logout" => 'session#destroy'
		end
		collection do
            get "signup" => 'users#new'
			post "users"  => 'users#create'
		end
	end
	resources :group  do 
		member do 
		end
		resources :users_group ,except:[:create, :show, :destroy, :update, :new, :edit] do
			collection do
				get 'accept_invitation' , as: 'accept_invitation' 
				get 'reject_invitation' , as: 'reject_invitation'
			end
		end
		resources :posts do 
			member do
			end 
			resources :comments do 
				member do
				end
			end 
		end
	end
	get  "login"  => 'session#new'
	post "login"  => 'session#create'
end

