class ArticlesController < ApplicationController
  load_and_authorize_resource  only: [:new, :create, :update, :remove] 
  helper_method :sort_column, :sort_direction 

  def index
    debugger
    if params[:search] 
      @articles = Article.search(params[:search]).order(sort_column + ' ' + sort_direction).paginate(:page => params[:page], :per_page => 5) 
    else  
      @articles = Article.all.paginate(:page => params[:page], :per_page => 5) 
    end  
  end

  def new
  end
  
  def create 
    @user = current_user
    @article = @user.articles.build(:title => params[:article][:title],:text=> params[:article][:text], :image=> params[:article][:image], :tag_list => params[:article][:tag_list])
    @article.tags
    @article.save
      redirect_to @article
  end

  def show
    @article = Article.find(params[:id]) 
   #@comment = Comment.new(:article => @article)
  end
  
  def edit
    @article = Article.find(params[:id]) 
  end
  
  
  def update
    if current_user.role == "admin" 
      @article = @article.update_attributes(params.require(:article).permit(:tag_list, :title, :text, :image))
      flash[:notice] = "admin successfully updated article."
      redirect_to article_path
    elsif current_user.role == "author" && @article.user_id == current_user.id
      @article = @article.update_attributes(params.require(:article).permit(:tag_list, :title, :text, :image))
      flash[:notice] = "author successfully updated article."
      redirect_to article_path
    else
      flash[:notice] = "you don't have the permmision for article update"
      render 'edit'
    end    
  end

  def remove
    @article = Article.find(params[:format])
    @article.delete
    flash[:notice] = "article destroy successfully."
    redirect_to articles_path    
  end

  def list
    @articles = Article.all.where(:user_id => current_user.id).paginate(:page => params[:page], :per_page => 5)   
  end 

  private  
  def sort_column  
    Article.column_names.include?(params[:sort]) ? params[:sort] : "title"  
  end   
    
  def sort_direction  
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"  
  end  


end
