class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
   puts "------ profile new------"
   puts params
    # capture the user_type passed in the route
    # @user_type = params[:user_type]
     @user_type = params[:user_type] 
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)
    puts "------profile create--"
    puts params[:profile][:user_type]
    # puts "--------- create method-------"
    # puts profile_params
    
    # connect user_id to the profile table
    @profile.user_id = current_user.id

    respond_to do |format|
      if @profile.save
        # if the user is buyer redirect to the root_path else redirect to listing a car's page
        if params[:profile][:user_type] == "buyer"
          # update the buyers table with the profile_id 
          @buyer = Buyer.new
          @buyer.profile_id = current_user.profile.id
          @buyer.save
          # after creating a profile user must be automatically redirect to listing a new car
          format.html { redirect_to root_path, notice: 'Profile was successfully created.' }
          format.json { render :show, status: :created, location: @profile }
        else
          # after creating a profile user must be automatically redirect to listing a new car
          format.html { redirect_to new_car_path, notice: 'Profile was successfully created.' }
          format.json { render :show, status: :created, location: @profile }
        end
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :user_name, :phone_number, :address, :user_id)
    end
end
