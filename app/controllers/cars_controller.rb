class CarsController < ApplicationController
  before_action :set_car, only: [:show, :edit, :update, :destroy]

  # GET /cars
  # GET /cars.json
  def index
    @cars = Car.all
  end

  # GET /cars/1
  # GET /cars/1.json
  def show
  end

  # GET /cars/new
  def new
    # if the user is not logged in redirect to the login page
    # else redirect to the cars form page
    if user_signed_in?
      # if the user has created a profile show the cars form else redirect to creating a profile page
       if current_user.profile
        @car = Car.new
        # render cars form page
       else
         redirect_to new_profile_path
       end
    else
        redirect_to new_user_session_path
    end
  end

  # GET /cars/1/edit
  def edit
  end

  # POST /cars
  # POST /cars.json
  def create
    @car = Car.new(car_params)
    
    # populate sellers table
    @seller = Seller.new
    @seller.profile_id = current_user.profile.id
    @seller.save

    # link the seller_id to the car model
    @car.seller_id = current_user.profile.seller.id

    respond_to do |format|
      if @car.save
        format.html { redirect_to @car, notice: 'Car was successfully created.' }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cars/1
  # PATCH/PUT /cars/1.json
  def update
    # delete the pictures before adding the new ones
    if @car.pictures
      @car.pictures.purge
    end
    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to @car, notice: 'Car was successfully updated.' }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/1
  # DELETE /cars/1.json
  def destroy
    @car.destroy
    respond_to do |format|
      format.html { redirect_to cars_url, notice: 'Car was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def car_params
      # link pictures to the cars controller
      params.require(:car).permit( :make, :model, :year, :km, :price, :color, :registration, :description, :fuel_type, :transmission_type, :location, pictures: [])
    end
end
