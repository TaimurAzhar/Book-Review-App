class ReviewsController < ApplicationController
	before_action :find_book 
	before_action :find_review , only: [:edit, :update, :destroy]
	before_action :authenticate_user!, only: [:new, :edit]
	

	def new
		@review = Review.new
	end

	def create
		@review = Review.new(review_params)
		@review.book_id = @book.id
		@review.user_id = current_user.id
		respond_to do |format|
			if @review.save 
				format.html {redirect_to book_path(@book)}
			else
				format.html {render :new}
			end
		end
	end

	def edit
		
	end


	def update
		
		respond_to do |format|
			if @review.update(review_params)
				format.html{ redirect_to book_path(@book) }
			else
				format.html{ render :edit}
			end
		end
	end

	def destroy
		@review.destroy
		respond_to do |format|
			format.html { redirect_to book_path(@book)}
		end

	end


	private 

		def review_params
			params.require(:review).permit( :rating, :comment)
		end	

		def find_book
			@book = Book.find(params[:book_id])
		end

		def find_review
			@review = Review.find(params[:id])
		end
		
end
