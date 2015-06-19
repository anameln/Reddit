class SubsController < ApplicationController

  before_action :must_be_moderator, only: [:edit, :update]
  before_action :must_be_logged_in, except: [:show, :index]

  def new
    @sub = Sub.new

    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id

    if @sub.save
      redirect_to subs_url
    else
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])

    render :edit
  end

  def update
    @sub = Sub.find(params[:id])

    if @sub.update(sub_params)
      redirect_to subs_url
    else
      render :edit
    end
  end

  def index
    @subs = Sub.all

    render :index
  end

  def show
    @sub = Sub.find(params[:id])

    render :show
  end


  private

  def sub_params
    params.require(:sub).permit(:title, :description)
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
