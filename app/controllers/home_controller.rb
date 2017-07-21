class HomeController < ApplicationController
  def index
    skip_authorization
    @homepage = Article.homepage
  end
end
