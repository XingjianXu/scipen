class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  add_breadcrumb 'People', :profiles_path

  # GET /profiles
  # GET /profiles.json
  def index
    skip_authorization
    @profiles = Profile.all
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    skip_authorization
    add_breadcrumb @profile.label, profile_path(@profile)
  end

  # GET /profiles/1/edit
  def edit
    authorize @profile

    if params[:id].present?
      add_breadcrumb 'Edit', edit_profile_path(@profile)
    else
      add_breadcrumb 'Edit', edit_current_user_profile_path
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    authorize @profile
    respond_to do |format|
      if @profile.update(profile_params)
        format.html {redirect_to params[:id].present? ? @profile : edit_current_user_profile_path, notice: 'Profile was successfully updated.'}
        format.json {render :show, status: :ok, location: @profile}
      else
        format.html {render :edit}
        format.json {render json: @profile.errors, status: :unprocessable_entity}
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_profile
    if params[:id].present?
      @profile = Profile.find(params[:id])
    else
      add_breadcrumb 'Profile', :current_user_profile_path
      @profile = current_user.profile
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def profile_params
    params.require(:profile).permit!
  end
end
