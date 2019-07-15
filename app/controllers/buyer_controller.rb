class BuyerController < ApplicationController
  def page
    @car = Car.find(params[:car_id])
    @seller = Seller.find(params[:seller_id])
  end

  def payment
      # update the cars table with buyers id
      # update the join table with seller and buyer id
      # buyers id  - current_user.profile.buyer
      # seller id - @car.seller_id
      # car -  params[:car_id]

      puts "-----payment-----"
      puts params
      # @buyer = current_user.profile.buyer
      # @car = Car.find(params[:car_id])
      # @seller = @car.seller
      # @buyer.cars << @buyer
      # @buyer.sellers << @seller

    @buyer = Buyer.find_by(profile_id: current_user.profile.id)

    @car = Car.find(params[:car_id])
    # link a buyer to the car
    @buyer.cars << @car

    # populate buyers_sellers table
    @seller = Seller.find(params[:seller_id])
    @buyer.sellers <<  @seller
  
    # redirect back to the car show page
    # car_path(@car.id)
      redirect_to @car, notice: "payment made successfully"
  end
end
