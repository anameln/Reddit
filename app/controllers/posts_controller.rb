class PostsController < ApplicationController

  # before_action :must_be_author, only: [:edit, :update]
  before_action :must_be_logged_in, except: [:show, :index]

  def new
    @post = Post.new

    render :new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to subs_url
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    must_be_author(@post)

    render :edit
  end

  def update
    @post = Post.find(params[:id])
    must_be_author(@post)

    if @post.update(post_params)
      redirect_to post_url(@post)
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
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end

  def must_be_author(post)
    unless current_user.id == post.author_id
      raise "Access denied."
    end
  end

  def must_be_logged_in
    redirect_to new_session_url unless current_user
  end


end
