class ProfilesController < InheritedResources::Base
  # before_action :set_article, only: %i[ show edit update destroy ]
   before_action :authenticate_user!, only: %i[ new edit destroy ]
  # before_action :owner?, only: %i[edit destroy]
  
  def index
    @profiles = Profile.all
    
  end

  
  def show
    @profile = Profile.find(params[:id])
  end

  
  def new

    @profile = Profile.new
  end

  
  def edit
    @profile = Profile.find(params[:id])
    unless current_user == @profile.user
      redirect_back fallback_location: root_path, notice: 'User is not owner'
    end
  end

  
  def create
    
    @profile = current_user.profile.create(profile_params)
    @profile.save
    # @user_profile = current_user.build_user_profile(user_profile_params)
    
    respond_to do |format|
      if @profile.save
        format.html { redirect_to profile_url(@profile), notice: "Profile was successfully created." }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: profile.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def update
    
    respond_to do |format|
      if profile.update(profile_params)
        format.html { redirect_to profile_url(@profile), notice: "Profile was successfully updated." }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def destroy
    @profile = current_user.profile.find(params[:id])
    @profile.destroy
   

    respond_to do |format|
      format.html { redirect_to profiles_url, notice: "Profile was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  

  private
    # def set_article
  
    #   @article = Article.find(params[:id])
    # end

  
    def profile_params
      params.require(:profile).permit(:name, :mobile, :bio)
    end



    # def owner?
    #   byebug
    #   unless current_user == profile.user
    #     redirect_back fallback_location: root_path, notice: 'User is not owner'
    #   end
    # end
end
