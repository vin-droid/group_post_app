Rails.application.routes.draw do
	root 'posts#index'
	resources :users ,only: [:update, :show,:destroy] do 
		member do 
			get '/signup' => 'users#new'
			get '/logout' => 'session#destroy'
			resources :posts do 
				member do
				end 
				resources :comments do 
					member do
					end
				end 
			end
			resources :group  do 
				member do 
				end
				resources :users_group ,exept:[:create ,:show,:destroy,:update,:new,:edit] do
					collection do
						get 'accept_invitation' , as: :accept_invitation
						get 'reject_invitation'
					end
				end
			end
		end
		collection do
			get '/login'  => 'session#new'
			post "login"  => 'session#create'
			post "users"  => 'users#create'
		end
	end
end

