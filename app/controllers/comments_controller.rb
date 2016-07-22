
class CommentsController < ApplicationController

	before_action :b_action,only:[:new,:show ,:edit,:update,:destroy ,:create]
	before_action :authorize ,except:[:show]



#  new comment
def new
	@comments = @post.comments.all
	@comment = @post.comments.new
end

# no use for show method
def show
end


# create new comment 
def create   
	@comment = @post.comments.create(find_params)
	@comment.user_id = current_user.id
	if @comment.save! 
		redirect_to new_post_comment_path(@post)
	else
		render 'new'
	end
end


# edit your comment
def edit
	@comments = @post.comments.all
	@comment = Comment.find(params[:id])
end


# destroy your comment
def destroy
	@comment = Comment.find(params[:id])
	@comment.destroy
	redirect_to  new_post_comment_path(@post)
end


# code for update your comment
def update
	@comment = Comment.find(params[:id])
	@comment.update(find_params)
	redirect_to new_post_comment_path(@post)
end






def like
	@comment.likes<< current_user.id if !@comment.likes.include?(current_user.id)
	@comment.save
	redirect_to root_path
end

def like
	@comment.dislikes<< current_user.id if !@comment.dislikes.include?(current_user.id)
	@comment.save
	redirect_to root_path
end


private 

def b_action
	@post = Post.find(params[:post_id])
end

def find_params
	params.require(:comment).permit(:desc,:user_id ,:post_id)
end

end
