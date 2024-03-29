class Place < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :current_rating, :title, :subtitle, :description , :images,:foodtype, :foursquare_venue, :latitude, :longitude, :rate_count
  has_many :items
  has_many :ratings
  serialize :foodtype
  serialize :images
  serialize :low_res_images
end
