class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_station

  def new
    # If user clicked 'Leave Review', it checks whether the user is logged in
    # and redirects to the station path.
    redirect_to station_path(@station, anchor: 'reviews')
  end

  def create
    @review = Review.new(review_params)
    @review.station = @station
    @review.user = current_user

    respond_to do |format|
      if !current_user.reviewed?(@station) && @review.save
        format.html { redirect_to station_path(@station), notice: 'Review was successfully saved and is pending review. It will be published soon.' }
      else
        msg = 'You have already reviewed this station.'
        msg = @station.errors.full_messages if @station.errors.any?
        format.html { redirect_to station_path(@station), alert: msg }
      end
    end
  end

  private
  def set_station
    @station = Station.friendly.find(params[:station_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def review_params
    params.require(:review).permit(:body)
  end
end
