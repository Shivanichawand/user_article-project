class LikesController < ApplicationController
	def create
		@like = current_user.likes.new(like_params)
		@like.save

		if !@like.save
			flash[:notice] = @like.errors.full_messages.to_sentence
		end 
		dislike = current_user.dislikes.find_by(article_id: @like.article.id)
		dislike.destroy if dislike
		redirect_to @like.article
	end

	def destroy
		@like = current_user.likes.find(params[:id])
		article = @like.article
		@like.destroy
		redirect_to article_path(article)
	end

	def like_params
		params.require(:like).permit(:article_id, :user_id)
	end


end
