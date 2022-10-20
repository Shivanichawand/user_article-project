class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[ new edit destroy ]
  before_action :owner?, only: %i[edit destroy]
  
  def index
    @articles = Article.all
    
  end

  
  def show
    @article = Article.find(params[:id])
  end

  
  def new

    @article = Article.new
  end

  
  def edit
    @article = Article.find(params[:id])
    unless current_user == @article.user
      redirect_back fallback_location: root_path, notice: 'User is not owner'
    end
  end

  
  def create
    @article = current_user.articles.create(article_params)
    
    respond_to do |format|
      if @article.save
        format.html { redirect_to article_url(@article), notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def update
    
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to article_url(@article), notice: "Article was successfully updated." }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def destroy
    @article = current_user.articles.find(params[:id])
    @article.destroy
   

    respond_to do |format|
      format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  

  private
    # def set_article
  
    #   @article = Article.find(params[:id])
    # end

  
    def article_params
      params.require(:article).permit(:title, :description, :image)
    end

  private

    def owner?
      unless current_user == @article.user
        redirect_back fallback_location: root_path, notice: 'User is not owner'
      end
    end
end
