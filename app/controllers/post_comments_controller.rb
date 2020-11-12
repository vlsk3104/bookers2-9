class PostCommentsController < ApplicationController
	def create
		@book = Book.find(params[:book_id])
		@comment = @book.post_comments.build(post_comment_params)
		@comment.user_id = current_user.id
		@comment.save
		render :index
	end
	def destroy
		@comment = PostComment.find_by(id: params[:id], book_id: params[:book_id])
		@comment.destroy
		render :index
	end
	private
	def post_comment_params
		params.require(:post_comment).permit(:comment, :book_id, :user_id)
	end
end
