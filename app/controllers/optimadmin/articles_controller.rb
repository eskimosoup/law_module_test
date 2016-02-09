module Optimadmin
  class ArticlesController < Optimadmin::ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy]

    def index
      @articles = Optimadmin::BaseCollectionPresenter.new(collection: Article.where('title ILIKE ?', "%#{params[:search]}%").page(params[:page]).per(params[:per_page] || 15), view_template: view_context, presenter: Optimadmin::ArticlePresenter)
    end

    def show
    end

    def new
      @article = Article.new
    end

    def edit
    end

    def create
      @article = Article.new(article_params)
      if @article.save
        redirect_to_index_or_continue_editing(@article)
      else
        render :new
      end
    end

    def update
      if @article.update(article_params)
        redirect_to_index_or_continue_editing(@article)
      else
        render :edit
      end
    end

    def destroy
      @article.destroy
      redirect_to articles_url, notice: 'Article was successfully destroyed.'
    end

  private


    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :summary, :content, :image,
      :image_cache, :remote_image_url, :remote_image, :social_share_image_cache,
      :remove_social_share_image, :remote_social_share_image_url,
      :social_share_title, :social_share_image, :social_share_description,
      :date, :suggested_url, :display, :home_page_highlight)
    end
  end
end
