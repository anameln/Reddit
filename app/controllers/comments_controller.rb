class CommentsController < ApplicationController

  def new
    @comment = Comment.new

    render :new
  end

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = params[:post_id]
    if @comment.save
      redirect_to post_url(params[:post_id])
    else
      render :new
    end
  end

  def show
    @comment = Comment.find(params[:id])

    render :show
  end

  helper_method :has_parent?

  def has_parent?(comment)
    !!comment.parent_comment_id
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
