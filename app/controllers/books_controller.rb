class BooksController < ApplicationController
	before_action :set_book, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, only: [:new, :edit]


	def index 
		if params[:category].blank?
			@books = Book.all.order("created_at DESC")
		else
			@category_id = Category.find_by(name: params[:category]).id
			@books = Book.where(category_id: @category_id).order("created_at DESC")
		end
		
	end
	def show
		if @book.reviews.blank?
			@average_rating = 0
		else
			@average_rating = @book.reviews.average(:rating).round(2)
		end
	end

	def new 
		@book = Book.new
		@categories = Category.all.map{ |c| [c.name, c.id]}

	end

	def create
		@book = current_user.books.new(book_params)
		respond_to do |format|
			if @book.save
				format.html {redirect_to root_path, notice: "Book Added"}
			else
				format.html {render :new}
			end
		end
	end

	def edit 
		@categories = Category.all.map{ |c| [c.name, c.id]}

	end

	def update
		respond_to do |format|
			if @book.update(book_params)
				format.html {redirect_to @book, notice: "Book Updated" }
			else
				format.html { render :edit}
			end
		end
	end

	def destroy
		@book.destroy
		respond_to do |format|
			format.html { redirect_to root_path, notice: "Book Deleted" }
		end
	end




	private 


		def book_params
			params.require(:book).permit(:title, :description, :author, :category_id, :book_img)
		end

		def set_book
			@book = Book.find(params[:id])
		end

end
