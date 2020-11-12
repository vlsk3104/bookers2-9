class BooksController < ApplicationController
	before_action :authenticate_user!
	def create
		@book=Book.new(book_id_params)
		@book.user_id = current_user.id
		if @book.save
		flash[:notice] = "You have created book successfully."
		redirect_to book_path(@book.id)
		else 
		@books=Book.all
		render :index
		end
	end

	def index
		@book = Book.new
		@books=Book.all
	end

	def show
		@book = Book.find(params[:id])
		@user = @book.user
		@post_comment = PostComment.new
		@comments = @book.post_comments.all
	end

	def edit
		@book =Book.find(params[:id])
		if @book.user_id != current_user.id
			redirect_to books_path
		end

	end

	def update
		@book = Book.find(params[:id])
		if @book.update(book_id_params)
		flash[:notice] = "You have updated book successfully."
		redirect_to book_path(@book)
		else render :edit
		end
	end

	def destroy
		@book=Book.find(params[:id])
		@book.destroy
		redirect_to books_path
	end

	private
	
	def book_id_params
		params.require(:book).permit(:title, :body)
	end
end
