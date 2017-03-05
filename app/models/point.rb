class Point < ActiveRecord::Base
  validates :latitude, :longitude, presence: true
  validates_inclusion_of :latitude, in: -90..90
  validates_inclusion_of :longitude, in: -180..180

  EARTH_R = 6371
  PI = 3.141592

  def calculate_range target_point_id
    target_point = Point.find(target_point_id)
    lat1 = to_radians(latitude)
    lon1 = to_radians(longitude)
    lat2 = to_radians(target_point.latitude)
    lon2 = to_radians(target_point.longitude)

    sin1 = Math.sin((lat1-lat2)/2)
    sin2 = Math.sin((lon1-lon2)/2)
    range = EARTH_R*2*Math.asin(Math.sqrt(sin1*sin1+sin2*sin2*Math.cos(lat1)*Math.cos(lat2)))
  end

  def to_radians deg
    deg*PI/180
  end
end
