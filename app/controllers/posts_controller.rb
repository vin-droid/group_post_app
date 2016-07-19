class PostsController < ApplicationController
	before_action :b_action , only:[ :show ,:update ,:destroy ,:edit ,:like,:dislike ]
	before_action :authorize ,except:[:show]


	def new
		@post = current_user.posts.new
	end



	def index
		@posts = Post.all.includes(:comments)
	end




	def show
	end




	def create
		@post = current_user.posts.create(find_params)
		if @post.save 
			redirect_to post_path(@post)
		else
			render 'new'
		end
	end



	def edit   
	end




	def destroy
		@post.destroy
		redirect_to @post
	end



	def update
		@post.update(find_params)
		redirect_to root_path
	end

	private 

	def b_action
		@post = Post.find(params[:id])
	end

	def find_params
		params.require(:post).permit(:title ,:content,:image)
	end

end
