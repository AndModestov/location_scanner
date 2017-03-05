class PointsController < ApplicationController
  before_action :find_point, only: [:show, :destroy, :find_nearest_points]
  before_action :build_new_point, only: :index

  respond_to :js, only: [:create, :destroy, :find_nearest_points]

  def index
    respond_with(@points = Point.all)
  end

  def show
    respond_with @point
  end

  def create
    @point = Point.new(point_params)

    if @point.save
      PrivatePub.publish_to "/points", point: @point.to_json
      render nothing: true
    else
      render json: { errors: @point.errors.full_messages }
    end
  end

  def destroy
    @point.destroy
    render json: { point: @point.id }
  end

  def find_nearest_points
    radius = params[:radius].to_f
    @point.get_nearest_points radius
    render nothing: true
  end

  private

  def find_point
    @point = Point.find(params[:id])
  end

  def build_new_point
    @point = Point.new
  end

  def point_params
    params.require(:point).permit(:latitude, :longitude)
  end
end
