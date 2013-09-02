class CommentsController < ApplicationController

  before_action :set_comment, only: [:show, :edit, :update, :destroy, :vote]
  before_action :set_post

  def index

  end

  def create
    @comment = Comment.new(comment_params)
    @comment.post = @post


    if @comment.save 
      flash[:notice] = 'Comment was added!'
      redirect_to post_path(@post)
    else
      render 'post/show'
    end
  end

  def vote
    Vote.create(votable:@comment,creator:current_user,vote:params[:vote])
    redirect_to post_path(@post)
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
      params.require(:comment).permit(:body)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
  
end