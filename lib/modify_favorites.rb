def is_favorite?(user, country)
  country_in_question = Trip.where(["user_id = :user_id and country_id = :country_id", { user_id: user.id, country_id: country.id}])[0]
  country_in_question.favorite == true
end

def modify_favorites(user)
  puts "Would you like to:"
  puts "1. Add a new favorite country"
  puts "2. Delete a favorite country"
  puts "3. Return to the menu selection screen"
  puts ""
  choice = gets.chomp.to_i
  puts ""
  case choice
  when 1
    puts "Which country would you like to add to your favorites?"
    country_name = check_country(gets.chomp)
    country = Country.find_by(name: country_name)

    if !has_been_to_country?(user, country)
      puts ""
      puts "You've never been there before, so how would you like to know if you'd like it or not?"
      sleep(2)
      puts ""
      modify_favorites(user)
    end

    if is_favorite?(user, country)
      system "clear"
      puts "You've already added this country to your favorites!"
      puts ""
      modify_favorites(user)
    end
    puts ""
    puts "What was your favorite thing about/to do in #{country.name}?  Please keep it under 255 characters."
    fav_thing = gets.chomp
    user.add_favorite(country, fav_thing)
    system "clear"
    puts "Done!"
    puts ""
    modify_favorites(user)

  when 2
    puts "Which country would you like to delete from your favorites?"
    country_name = check_country(gets.chomp)
    country = Country.find_by(name: country_name)

    if !has_been_to_country?(user, country)
      system "clear"
      puts "You've never been to #{country.name}, you might actually like it!"
      puts ""
      modify_favorites(user)
    end

    if !is_favorite?(user, country)
      system "clear"
      puts "This is not one of your favorite countries!"
      puts ""
      modify_favorites(user)
    end

    user.delete_favorite(country)
    system "clear"
    puts "Done!"
    puts ""
    modify_favorites(user)

  when 3
    system "clear"
    main_menu(user)
  else
    system "clear"
    puts "Invalid response."
    puts ""
    modify_favorites(user)
  end
end

