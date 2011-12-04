class CommentsController < ApplicationController
  before_filter :require_user

  respond_to :html, :js

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    
    respond_with @comment do |format|
      format.html { redirect_to root_path }
    end
  end

end
