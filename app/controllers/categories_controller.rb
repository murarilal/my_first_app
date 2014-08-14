class CategoriesController < ApplicationController
  load_and_authorize_resource  only: [:new, :create, :update] 
  before_action :set_category, only: [:show, :edit, :update, :destroy] 

  def index
    @categories = Category.all
  end 

  def new
  	@category = Category.new
  end
  
  def create
  	@category = Category.new(category_params)
  	if @category.save
  	  redirect_to @category
  	else
  	  render 'new'  
  	end  
  end

  def show
  	@category = Category.find(params[:id])
  end	

  def category_products
    @category_products = Product.all.where(:category_id => params[:format])
  end  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through. 
    def category_params
  	  params.require(:category).permit(:name)
    end 

end
