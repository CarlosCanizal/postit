class CommentsController < ApplicationController

  before_action :set_post
  before_action :set_comment, only: [:show, :edit, :update, :destroy, :vote]
  before_action :access_denied, only:[:vote]

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
    if already_voted?(@post)
      flash[:notice] = 'You already voted in this comment.'
    else
      Vote.create(votable:@comment,creator:current_user,vote:params[:vote])
    end
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