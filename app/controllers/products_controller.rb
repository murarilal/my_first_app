class ProductsController < ApplicationController

  def index
    @search = Product.search do
      fulltext params[:search]
      with(:created_at).less_than(Time.zone.now)
    end
    @products = @search.result
  end	

  def new
  	@product = Product.new
  	@categories = Category.all
  end
  
  def create
    @product = current_user.products.build(product_params) 
    if @product.save
  	  redirect_to @product
  	else
  	  render 'new'  
  	end  
  end

  def show
  	@product = Product.find(params[:id])
  end
  
  def edit
  	@product = Product.find(params[:id])
  	@categories = Category.all
  end
  
  def update
  	@product = Product.find(params[:id])
  	@product = @product.update(product_params)
      redirect_to product_path 
  end	 	
  
  private

  def product_params
  	params.require(:product).permit(:name, :description, :category_id, :user_id)
  end

end
