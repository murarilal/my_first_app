class CommentsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource  only: [:update, :remove]


  def create
    @comment = Comment.new(comment_params)
    @comment.save
    redirect_to article_path(@article)
  end

  def edit
    @comment = Comment.find(params[:id])
  end    

  def update
    if current_user.role == "admin" || current_user.role == "author"
      @article = Article.find(params[:article_id])
      @comment = @comment.update_attributes(comment_params)
        redirect_to article_path(@article)
    else
        if @comment.user_id == current_user.id
          @article = Article.find(params[:article_id])
          @comment = @comment.update_attributes(comment_params)
            redirect_to article_path(@article)    
        else
          render 'comments/edit'
        end  
    end      
  end  
  
  def remove
    if current_user.role == "admin" || current_user.role == "author"
      @comment = Comment.find(params[:format])
      @comment.delete
        redirect_to articles_path
    else    
        if @comment.user_id == current_user.id
          @comment = Comment.find(params[:format])
          @comment.delete
          redirect_to articles_path
        else
          redirect_to articles_path
        end
    end            
  end


  private
    def comment_params
      params.require(:comment).permit(:commenter, :body).merge(:user_id => current_user.id, :article_id => params[:article_id])
    end
end
