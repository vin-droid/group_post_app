
class CommentsController < ApplicationController

	before_action :b_action, only:[:new,:show, :edit, :update, :destroy, :create]
	before_action :authorize
	before_action :find_comment, only:[:destroy, :edit, :update,:show ]

# create new comment 
def create   
	@comment = Comment.create!(find_params)
	if @comment.save! 
		redirect_to group_path(@group)
	else
		render 'group/show'
	end
end
def edit
	@comment = Comment.find(params[:id])
end
def destroy
	@comment = Comment.find(params[:id])
	@comment.destroy
	redirect_to group_path(@group)
end

def update
	@comment.update(find_params)
    redirect_to group_path(@group)
end

private 

def b_action
	@post  = Post.find(params[:post_id])
	@group = Group.find(params[:group_id])
end

def find_params
	params[:comment][:user_id]  = @current_user.id
	params[:comment][:post_id]  = params[:post_id]
	params.require(:comment).permit(:content, :user_id, :post_id)
end

end
