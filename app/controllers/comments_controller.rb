class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.bookmark = Bookmark.find(params[:bookmark_id])
    if @comment.save
      redirect_to list_path(@comment.bookmark.list)
    else
      render list_path(@comment.bookmark.list)
  end


  private

  def comment_params
    params.require(:comment).permit(:body, :rating)
  end
end
