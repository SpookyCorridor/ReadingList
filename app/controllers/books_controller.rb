class BooksController < ApplicationController
	def index
		books = Book.all 

		if rating = params[:rating]
			books = books.where(rating: rating)
		end 
		render json: books, status: 200 
	end 

	def create
		book = Book.new(book_params)
		if book.save
			# location will render a link for the activerecord 
			render json: book, status: 201, location: book
		else 
			render json: book.errors, status: 422 
		end 
	end 

	def destroy  
		book = Book.find(params[:id])
		book.destroy!
		# render with an empty response body 
		render nothing: true, status: 204
	end 

	def book_params
		params.require(:book).permit(:title, :rating, :author, 
			:review, :genre_id, :amazon_id )
	end 
end 