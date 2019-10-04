def forget_trip(user)
  puts "Which country would you like to forget about?"
  country_name = check_country(gets.chomp)
  bad_country = Country.find_by(name: country_name)

  if !has_been_to_country?(user, bad_country)
    puts "You've never been there before!  #{bad_country.name} can't be that bad..."
    sleep(1)
    puts ""
    return_to_menu(user)
  end
  puts ""
  puts "Wow, was #{bad_country.name} that bad?  Let's just forget you ever went there."
  Trip.where(country_id: bad_country.id, user_id: user.id)[0].destroy
  
  puts ""
  return_to_menu(user)
end
