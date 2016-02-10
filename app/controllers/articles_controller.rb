class ArticlesController < ApplicationController
  before_action :find_article, only: :show

  def index
    @articles = Article.displayed
  end

  def show
    return redirect_to @article, status: :moved_permanently if request.path != article_path(@article)
  end

  private

  def find_article
    @article = Article.displayed.find(params[:id])
  end
end
