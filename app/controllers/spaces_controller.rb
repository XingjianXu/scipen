class SpacesController < ApplicationController
  before_action :set_space, only: [:show, :edit, :update, :destroy]

  add_breadcrumb 'Spaces', :spaces_path

  # GET /spaces
  # GET /spaces.json
  def index
    skip_authorization
    t_spaces = Space.arel_table
    @categories = Category.includes(:spaces)
    if user_signed_in?
      @categories = @categories
                        .where('spaces.user_id': current_user.id)
                        .or(@categories.where('spaces.visibility': [:trusted, :unrestricted]))
    else
      @categories = @categories.where('spaces.visibility': :unrestricted)
    end

    @categories = @categories.order('categories.name, spaces.name').distinct
  end

  # GET /spaces/1
  # GET /spaces/1.json
  def show
    authorize @space
    add_breadcrumb @space.name, space_path(@space)
    if @space.articles.any?
      redirect_to @space.articles.first.decorate.show_path
    end
  end

  # GET /spaces/new
  def new
    authorize :space, :new?
    add_breadcrumb 'New', :new_space_path
    @space = Space.new
  end

  # GET /spaces/1/edit
  def edit
    authorize @space
    add_breadcrumb @space.name, space_path(@space)
    add_breadcrumb 'Edit', edit_space_path(@space)
  end

  # POST /spaces
  # POST /spaces.json
  def create
    @space = Space.new(space_params)
    authorize @space
    respond_to do |format|
      if @space.save
        format.html {redirect_to @space, notice: 'Space was successfully created.'}
        format.json {render :show, status: :created, location: @space}
      else
        format.html {render :new}
        format.json {render json: @space.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /spaces/1
  # PATCH/PUT /spaces/1.json
  def update
    authorize @space
    respond_to do |format|
      if @space.update(space_params)
        format.html {redirect_to edit_space_path(@space), notice: 'Space was successfully updated.'}
        format.json {render :show, status: :ok, location: @space}
      else
        format.html {render :edit}
        format.json {render json: @space.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /spaces/1
  # DELETE /spaces/1.json
  def destroy
    authorize @space
    @space.destroy
    respond_to do |format|
      format.html {redirect_to spaces_url, notice: 'Space was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_space
    @space = Space.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def space_params
    params.require(:space).permit!
  end
end
