require_relative '../config/environment'
require 'pry'
# url = "https://restcountries.eu/rest/v2/all"

# Get the body data form RESTClient RESTClient.get
response = RestClient.get("https://restcountries.eu/rest/v2/all")

# Format the data as JSON with JSON.parse
countries = JSON.parse(response)
countries.each do |country|
  name = country["name"]
  capital = country["capital"]
  Country.create(name: name, capital: capital, times_visited: 0, times_favorited: 0)
end

