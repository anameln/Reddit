class PostsController < ApplicationController

  before_action :must_be_moderator, only: [:edit, :update]
  before_action :must_be_logged_in, except: [:show, :index]

  def new
    @post = Post.new

    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.moderator_id = current_user.id

    if @post.save
      redirect_to posts_url
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])

    render :edit
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to posts_url
    else
      render :edit
    end
  end

  def index
    @posts = Post.all

    render :index
  end

  def show
    @post = Post.find(params[:id])

    render :show
  end


  private

  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_id)
  end

  def must_be_moderator
    unless current_user.id == moderator_id
      raise "Access denied."
    end
  end

  def must_be_logged_in
    redirect_to new_session_url unless current_user
  end


end
