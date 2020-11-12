class FavoritesController < ApplicationController
	def create
		@book= Book.find(params[:book_id])
		favorite = current_user.favorites.new(book_id: @book.id)
		favorite.save
	end

	def destroy
		# @book =>favorite.htmlに反映したものが、books/indexに部分的に表示されるため
		@book = Book.find(params[:book_id])
		favorite = Favorite.find_by(user_id: current_user.id, book_id: @book.id).destroy
	end

end
