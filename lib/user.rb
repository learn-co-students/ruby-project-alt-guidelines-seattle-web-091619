class User < ActiveRecord::Base
  has_many :trips
  has_many :countries, through: :trips

  def add_favorite(country, fav_thing)
    country.update_column(:times_favorited, country.times_favorited + 1)
    new_favorite = Trip.where(["user_id = :user_id and country_id = :country_id", { user_id: self.id, country_id: country.id}])[0]
    new_favorite.update_column(:favorite, true) 
    new_favorite.update_column(:favorite_thing, fav_thing)
  end

  def delete_favorite(country)
    country.update_column(:times_favorited, country.times_favorited - 1)
    bad_country = Trip.where(["user_id = :user_id and country_id = :country_id", { user_id: self.id, country_id: country.id}])[0]
    bad_country.update_column(:favorite, false)
    bad_country.update_column(:favorite_thing, nil)
  end
end