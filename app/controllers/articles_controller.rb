require 'fileutils'

class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy, :assets, :asset]
  before_action :set_space, only: [:new, :create, :show, :edit, :update, :destroy, :assets, :asset]

  # GET /articles
  # GET /articles.json
  def index
    skip_authorization
    @articles = Article.all
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    authorize @article
    if @article.space
      add_breadcrumb @article.space.category.name, category_path(@article.space.category)
    end
  end

  # GET /articles/new
  def new
    authorize @space, :edit?
    @article = Article.new_template
    @article.space = @space
  end

  # GET /articles/1/edit
  def edit
    authorize @article
  end

  # POST /articles
  # POST /articles.json
  def create
    authorize @space, :edit?
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save!
        format.html {redirect_to @article.space.present? ? space_article_path(@article.space.id, @article.id) : @article, notice: 'Article was successfully created.'}
        format.json {render :show, status: :created, location: @article}
      else
        format.html {render :new}
        format.json {render json: @article.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    authorize @article

    respond_to do |format|
      if @article.update(article_params)
        format.html {redirect_to edit_article_path(@article), notice: 'Article was successfully updated.'}
        format.json {render :show, status: :ok, location: @article}
      else
        format.html {render :edit}
        format.json {render json: @article.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    authorize @article

    @article.destroy
    respond_to do |format|
      format.html {redirect_to @article.space, notice: 'Article was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  def assets
    authorize @article, :update?
    if request.post?
      FileUtils.mv params[:file].tempfile, @article.assets_dir(params[:file].original_filename)
      render json: {
          uid: params[:file].original_filename,
          name: params[:file].original_filename,
          status: 'done',
          url: asset_article_url(file_name: params[:file].original_filename)
      }
    elsif request.get?
      file_list = @article.assets.collect do |asset|
        {
            uid: asset,
            name: asset,
            status: 'done',
            url: asset_article_url(file_name: asset)
        }
      end
      render json: file_list
    end
  end

  def asset
    file = @article.assets_dir(params[:file_name])
    if request.get?
      authorize @article, :show?
      send_file file
    elsif request.delete?
      authorize @article, :update?
      FileUtils.rm file
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id]).decorate
    gon.article_id = @article&.id
  end

  def set_space
    space_id = params[:space_id] || params[:article][:space_id]
    @space = space_id.present? ? Space.find_by_id(space_id) : @article.space
    unless @article&.homepage?
      add_breadcrumb 'Spaces', :spaces_path
      add_breadcrumb @space.name, space_path(@space.id)
    end
    case params[:action]
      when 'new'
        add_breadcrumb 'New', new_space_article_path(@space)
      when 'edit'
        if @article&.homepage?
          add_breadcrumb @article.title, root_path
        else
          add_breadcrumb 'Articles', space_path(@space.id)
          add_breadcrumb @article.title, space_article_path(@article.space, @article)
        end
        add_breadcrumb 'Edit', edit_article_path(@article)
    end
    gon.space_id = @space&.id
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def article_params
    params.require(:article).permit!
  end
end
