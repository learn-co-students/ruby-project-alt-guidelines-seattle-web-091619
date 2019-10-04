def add_new_trip(user)
  puts "Where did you go?"
  input = gets.chomp.capitalize
  country_name = check_country(input)
  country = Country.find_by(name: country_name)

  if has_been_to_country?(user, country)
    puts "You've already been there!"
    sleep(1)
    add_new_trip(user)
  end

  Trip.create(user_id: user.id, country_id: country.id)
  times_visited = country.times_visited + 1
  country.update_column(:times_visited, times_visited)
  puts ""
  puts "#{country.name} has been added to the list of countries you have been to."

  puts ""
  return_to_menu(user)
end