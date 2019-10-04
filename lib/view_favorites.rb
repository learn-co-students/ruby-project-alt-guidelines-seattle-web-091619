def view_favorites(user)
  favorite_countries = user.trips.where(favorite: true)
  country_ids = favorite_countries.map { |trip| trip.country_id }
  if country_ids == []
    puts "You have no favorite countries!"
    puts ""
    return_to_menu(user)
  end

  country_ids.each do |id|
    puts "#{Country.find_by(id: id).name}: #{Trip.where(country_id: id, user_id: user.id)[0].favorite_thing}"
  end

  puts ""
  return_to_menu(user)
end