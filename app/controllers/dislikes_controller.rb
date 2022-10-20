class DislikesController < ApplicationController
	def create
		@dislike = current_user.dislikes.new(dislike_params)
		@dislike.save

		if !@dislike.save
			flash[:notice] = @dislike.errors.full_messages.to_sentence
		end 
		like = current_user.likes.find_by(article_id: @dislike.article.id)
		like.destroy if like
		redirect_to @dislike.article
	end

	def destroy
		@dislike = current_user.dislikes.find(params[:id])
		article = @dislike.article
		@dislike.destroy
		redirect_to article_path(article)
	end

	def dislike_params
		params.require(:dislike).permit(:article_id, :user_id)
	end
end
