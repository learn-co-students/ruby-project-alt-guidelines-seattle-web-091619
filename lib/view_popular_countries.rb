def view_popular_countries(user)
  # Change this eventually to times_favorited
  # keeping it at visited for now to see if it works
  visited_countries = Country.order(times_visited: :desc).limit(5)
  favorited_countries = Country.order(times_favorited: :desc).limit(5)
  puts "Top 5 most frequently visited countries:"
  visited_countries.each { |country| puts country.name }

  puts ""

  puts "Top 5 most frequently favorited countries:"
  favorited_countries.each { |country| puts country.name }

  puts ""
  return_to_menu(user)
end