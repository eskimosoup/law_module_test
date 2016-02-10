class ArticlePresenter < BasePresenter
  presents :article
  delegate :title, to: :article

  def linked_title(text = 'View', options = {})
    h.link_to text, article, options
  end

  def summary
    h.simple_format article.summary
  end

  def content
    h.raw article.content
  end

  def social_share_title
    article.social_share_title || article.title
  end

  def social_share_description
    article.social_share_description || article.summary
  end

  def date(format = :default)
    h.l article.date, format: format
  end
end
