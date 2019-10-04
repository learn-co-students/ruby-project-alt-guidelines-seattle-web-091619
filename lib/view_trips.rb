def view_trips(user)
  user_trips = Trip.where(user_id: user.id)

  if user_trips == []
    puts "Apparently you've never been anywhere, how sad."
    puts ""
    return_to_menu(user)
  end

  user_countries_ids = user_trips.map { |trip| trip.country_id }.uniq
  puts "Here are the countries that you have visited so far:"
  user_countries_ids.each { |country_id| puts Country.find_by(id: country_id).name }
  
  puts ""
  return_to_menu(user)
end