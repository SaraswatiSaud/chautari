class StationsController < ApplicationController
  before_action :authenticate_admin!, except: [:new, :create, :index, :show, :play, :playing_now, :player_close, :similar, :thankyou]
  before_action :set_station, only: [:show, :edit, :update, :destroy, :play, :similar, :playing_now, :thankyou]

  # rescue_from ActiveRecord::RecordNotFound, with: :invalid_station
  # def invalid_station
  #   redirect_to root_path, alert: 'Station not available!'
  # end

  impressionist actions: [:show], unique: [:session_hash]

  # GET /stations
  # GET /stations.json
  def index
    stations = Station.order(updated_at: :desc)

    # Also display pending stations if admin
    stations = stations.active unless (user_signed_in? && current_user.is_admin?)
    @stations = stations.order(id: :desc).page params[:page]
  end

  # GET /stations/1
  # GET /stations/1.json
  def show
    redirect_to root_path, alert: 'Station not available!' unless @station.active? || (user_signed_in? && current_user.is_admin?)
    impressionist(@station)
  end

  # GET /stations/new
  def new
    @title = 'Add New Radio Station'
    @station = Station.new
  end

  # GET /stations/1/edit
  def edit
  end

  # POST /stations
  # POST /stations.json
  def create
    @station = Station.new(station_params)

    respond_to do |format|
      if @station.save
        # If admin creates a station, redirect to show page.
        # If guest creates a station, redirect to thank you page.
        path = (user_signed_in? && current_user.is_admin?) ? @station : thankyou_station_path(@station)

        format.html { redirect_to path, notice: 'Station was successfully saved.' }
        format.json { render :show, status: :created, location: @station }
      else
        format.html { render :new }
        format.json { render json: @station.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stations/1
  # PATCH/PUT /stations/1.json
  def update
    respond_to do |format|
      begin
        if @station.update(station_params)
          format.html { redirect_to @station, notice: 'Station was successfully updated.' }
          format.json { render :show, status: :ok, location: @station }
        else
          format.html { render :edit }
          format.json { render json: @station.errors, status: :unprocessable_entity }
        end
      rescue => e
        flash.now[:alert] = "<b>Error: </b>#{e}".html_safe
        format.html { render :edit }
      end
    end
  end

  # DELETE /stations/1
  # DELETE /stations/1.json
  def destroy
    @station.destroy
    respond_to do |format|
      format.html { redirect_to stations_url, notice: 'Station was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def play
    session[:stream] = @station.streams.try(:first).try(:attributes)
  end

  def playing_now
    @playing_now = @station.playing_now
  end

  def player_close
    session[:stream] = nil
  end

  def similar
    @stations = @station.similar_stations
  end

  # Displays thank you page after guest adds a radio station
  def thankyou
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_station
    @station = Station.friendly.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def station_params
    params.require(:station).permit(
      :name, :tagline, :description, :country_id, :language_id, :slug, :logo,
      :website, :twitter, :facebook, :address, :contact, :email,
      category_ids: [],
      streams_attributes: [ :id, :url, :_destroy ]
    )
  end
end
