require 'pry'

def welcome_screen
  system "clear"
  puts asciiart
  puts
end

def login
  puts "Is this your first time traveling?"
  puts "(Y)es/(N)o"
  response = gets.chomp.upcase
  response = invalid_response(response)
  if response == "N"
    system "clear"
    puts "Please enter your username or type \'back\' to return to the selection screen: "
    username = gets.chomp
    return_to_selection(username)
    is_user(username)
  elsif response == "Y"
    system "clear"
    puts "No problem! Let's get you started!\n"
    create_traveler
  end
end

def invalid_response(response)
  while response != "Y" && response != "N"
    puts ""
    puts "Invalid response. Please choose either \'Y\' for yes or \'N\' for no."
    response = gets.chomp.upcase
  end
  response
end

def return_to_selection(input)
  if input.downcase == "back"
    system "clear"
    login
  end
end

# Checks if the inputed username is a valid username
# If it is, it calls the main_menu method to direct user to the main menu
def is_user(username)
  user = User.find_by(name: username)
  if user
    system "clear"
    puts "Welcome back #{user.name}!"
    puts ""
    main_menu(user)
  else
    while !user
      puts ""
      puts "User not found.  Please reenter your username or type \'back\' to return to the selection screen:"
      username = gets.chomp
      user = User.find_by(name: username)
      return_to_selection(username)
    end
    system "clear"
    puts "Welcome back #{user.name}!"
    puts ""
    main_menu(user)
  end
end

def create_traveler
  puts "Enter a new username (do not use any spaces or special characters):"
  username = gets.chomp
  while User.find_by(name: username)
    puts ""
    puts "Sorry, this username is already taken."
    puts "Please choose a different username:"
    username = gets.chomp
  end
  new_user = User.create(name: username)
  join_countries_and_users(new_user)
  system "clear"
  puts "Welcome #{new_user.name}!"
  puts ""
  main_menu(new_user)
end

# Establishing relationship between a NEW user and any countries they've visited through trips
def join_countries_and_users(user)
  system "clear"
  puts "Please enter the name of any countries you have traveled to one by one."
  puts "Press \'return/enter\' after entering the country."
  puts "Once you are finished, type \'done\'."
  country = gets.chomp.capitalize
  while country.downcase != "done"
    country = check_country(country)
    # Once the country is verified, look through the country table to find the matching country and get its attributes
    country = Country.find_by(name: country.split(/ |\_/).map(&:capitalize).join(" "))
    Trip.create(user_id: user.id, country_id: country.id)
    times_visited = country.times_visited + 1
    country.update_column(:times_visited, times_visited)
    country = gets.chomp.capitalize
  end
end

# A helper method that checks if the user inputted country is a real country
# The input will be compared to the country names from the api
def check_country(name)
  while !Country.find_by(name: name.split(/ |\_/).map(&:capitalize).join(" "))
    system "clear"
    puts "I don't think that's a real country.  Please enter a real country (ideally one on Earth)."
    name = gets.chomp

    # Special case when check_country is being run on a new user
    if name.downcase == "done"
      system "clear"
      puts "Welcome #{new_user.name}!"
      puts ""
      main_menu(new_user)
    end

  end
  name.split(/ |\_/).map(&:capitalize).join(" ")
end

def return_to_menu(user)
  puts "1. Return to the menu selection screen"
  puts "2. Exit"
  puts ""
  selection = gets.chomp.to_i
  if selection == 1
    system "clear"
    main_menu(user)
  elsif selection == 2 
    system "clear"
    puts "Goodbye!"
    sleep(2)
    system "clear"
    exit
  else
    system "clear"
    puts "Invalid response.  Please make a selection from the menu screen"
    puts ""
    return_to_menu(user)
  end
end

def has_been_to_country?(user, country)
  user_trips = Trip.where(user_id: user.id)
  user_countries_ids = user_trips.map { |trip| trip.country_id }.uniq
  user_countries_ids.include?(country.id)
end

def main_menu(user)
  puts "Main Menu \n"
  puts "1. Add a country you've visited"
  puts "2. View the countries you've visited"
  puts "3. Add/delete a favorite country"
  puts "4. View your favorite countries"
  puts "5. View the most popular countries"
  puts "6. Forget about a country you've visited"
  puts "7. Exit"
  puts ""
  selection = gets.chomp.to_i
  system "clear"
  case selection
  when 1
    add_new_trip(user)
  when 2
    view_trips(user)
  when 3
    modify_favorites(user)
  when 4
    view_favorites(user)
  when 5
    view_popular_countries(user)
  when 6
    forget_trip(user)
  when 7
    puts "Goodbye!"
    sleep(2)
    system "clear"
    exit
  else
    system "clear"
    puts "Invalid response.  Please make a selection from the menu screen"
    puts ""
    main_menu(user)
  end
end
