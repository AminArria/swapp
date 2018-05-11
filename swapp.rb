#!/usr/bin/ruby
require 'json'
require 'net/http'

def swapi_get(url, search: nil)
  search = search ? "?search=#{search}" : ''
  uri = URI(url + search)
  response = Net::HTTP.get(uri)
  JSON.parse(response, symbolize_names: true)
end

char1 = ARGV[0]
char2 = ARGV[1]

if char1.nil? || char2.nil?
  abort("You need to specify TWO character names in the script arguments")
end

# Get char1 films IDs
response = swapi_get('https://swapi.co/api/people/', search: char1)

if response[:count] == 0
  abort("#{char1} is not a character in Star Wars")
end

char1_films = response[:results][0][:films]
char1_films.map! { |url| url.split('/').last }

# Get char2 films IDs
response = swapi_get('https://swapi.co/api/people/', search: char2)

if response[:count] == 0
  abort("#{char2} is not a character in Star Wars")
end

char2_films = response[:results][0][:films]
char2_films.map! { |url| url.split('/').last }

# Common films
common_films = char1_films & char2_films

common_films.each do |film_id|
  response = swapi_get("https://swapi.co/api/films/#{film_id}/")
  puts response[:title]
end