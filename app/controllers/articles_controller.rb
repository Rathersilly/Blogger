class ArticlesController < ApplicationController
  include ArticlesHelper
  before_filter :require_login, except: [:show, :index]

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
    @article.views += 1
    @article.save

    @comment = Comment.new
    @comment.article_id = @article.id
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.views = 0
    @article.save

    flash.notice = "Article #{@article.id} ('#{@article.title}') Created! #{@article.views} Views!}"

    redirect_to article_path(@article)
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.update(article_params)

    flash.notice = "Article '#{@article.title}' Updated!"

    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    flash.notice = "Article #{@article.title} Pulverized!"

    redirect_to articles_path(@articles)
  end
end
