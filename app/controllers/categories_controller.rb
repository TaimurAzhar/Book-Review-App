class CategoriesController < ApplicationController

  def new
  	@category = Category.new
  end

  def create
  	@category = Category.new(category_params)
  	respond_to do |format|
  		if @category.save 
  			format.html{ redirect_to books_path}
  		else
  			format.html{ render :new}
  		end
  	end
  end

  def show 
  	@category.find(param[:id])
  end



  private

  	def category_params
  		params.require(:category).permit(:name)
  	end


  	def set_category
  		@category.find(param[:id])
  	end


end
