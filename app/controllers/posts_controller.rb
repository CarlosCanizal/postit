class PostsController < ApplicationController

  before_action :set_post, only: [:show, :edit, :update, :destroy, :vote]
  before_action :access_denied, only:[:vote, :create]
  before_action :verify_admin, only:[:update,:edit]

  def index
    @posts = Post.all
  end

  def show
    @comment = Comment.new
    @comments = @post.comments
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.' 
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.' 
    else
      render action: 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url
  end

  def vote
    @already_voted = already_voted?(@post)
    if @already_voted
      @message = 'You already voted in this post.'
    else
      Vote.create(voteable:@post,creator:current_user,vote:params[:vote])
      @message = nil
    end

    respond_to do |format|
      format.html {redirect_to :back}
      format.js
    end
  end


  private

  def set_post
    @post = Post.find_by(slug:params[:id])
  end

  def post_params
      params.require(:post).permit(:title, :url, :description)
  end

  def verify_admin
      redirect_to root_path,notice:'You can\'t do that.' unless current_user.admin?
  end

end
