class CommentsController < ApplicationController
  http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]
  before_action :set_article
  before_action :set_comment, only: %i[show edit update destroy]

  def index
    @comment = @article.comments
  end

  def show 
  end

  def create
        @comment = @article.comments.create(comment_params) 
    if @comment.save
      redirect_to article_path(@article), notice: 'Comment succesfully posted'
    elsif 
      flash.alert = 'Failed to post comment'
      render 'articles/show', status: :unprocessable_entity 
    end
  end

  def edit
        
  end

 def update
  if @comment.update(comment_params)
    redirect_to article_comment_path(@article, @comment), notice: 'Comment updated successfully.'
  else
    flash.alert = 'Failed to update comment.'
    render :edit, status: :unprocessable_entity
  end
end


  def destroy
        
    @comment.destroy
    redirect_to article_path(@article), status: :see_other
  end
 
  private
    def comment_params
      params.require(:comment).permit(:commenter, :body, :status)
    end

  def set_article
    @article = Article.find(params[:article_id])
    
  end

  def set_comment
    @comment = @article.comments.find(params[:id])
  end

end
