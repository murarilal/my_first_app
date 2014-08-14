class SearchController < ApplicationController
  
  def search
  	if params[:search]
       @found_stories = Product.find_all_by_(params[:search])
       @found_stories = Category.find_all(params[:search])
       @found_books= Article.find_all_by_title(params[:search])
    end
  end	

end
