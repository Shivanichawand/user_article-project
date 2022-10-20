class CommentsController < ApplicationController
	def show
    @article = Article.find(params[:article_id])
    @comment = current_user.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    @comment.user = current_user
    @comment.save
    redirect_to article_path(@article)
  end


  def destroy
    @article = Article.find(params[:article_id])
    @comment = current_user.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article), status: :see_other
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :description, :parent_id)
    end
end
