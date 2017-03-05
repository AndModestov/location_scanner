class PointsController < ApplicationController
  before_action :find_point, only: [:show, :destroy]
  before_action :build_new_point, only: :index

  respond_to :js, only: [:create, :destroy]

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
