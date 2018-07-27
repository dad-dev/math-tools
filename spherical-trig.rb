# The haversine formula calculates the great-circle distance between two points
# over the surface of the Earth as the crow flies.
# Returns a distance value in Kilometers, but I've included a conversion to miles.

# And what's a haversine?  Well, since you asked...
# From the trigonmetric function versine, or versed sine, the versine of an
# angle equals 1 minus its cosine.  Coversine is 1 - sin, and haversine is
# half a versine.  Haversines have been historically important in
# navigation because, using the haversine formula, one can compute reasonably
# accurate distances even across an oblate spheroid which is what our
# precious Earth is.


class Numeric
  Math.methods(false).each do |m|
    define_method(m) {|*args| Math.send(m, self, *args) }
  end
end


class Geo
  include Math
  def initialize
    @RAD = 6371 # Earth radius in km
  end

  def haversine(lat_1, lon_1, lat_2, lon_2)
    delta_lat = to_rad(lat_2 - lat_1)
    delta_lon = to_rad(lon_2 - lon_1)
    lat_1 = to_rad(lat_1)
    lat_2 = to_rad(lat_2)

    a = (delta_lat / 2).sin * (delta_lat / 2).sin +
        (delta_lon / 2).sin * (delta_lon / 2).sin * lat_1.cos * lat_2.cos

    c = 2 * atan2(a.sqrt, (1 - a).sqrt)
    d = @RAD * c # km
    m = d * 0.621371192 # miles
    m.round(2)
  end

  def to_rad(deg)
    deg * PI / 180
  end
end


# Test
hs = Geo.new
puts "New york to San Francisco is about #{hs.haversine(40.7128, 74.0060, 37.7749, 122.4194)} miles."
