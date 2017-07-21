class ArticleDecorator < Draper::Decorator
  delegate_all

  def show_path
    h.space_article_path(object.space, object)
  end

  def edit_path
    h.send("edit_#{article.space.class.name.downcase}_article_path", article.space_id, article.id)
  end


end
