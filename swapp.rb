#!/usr/bin/ruby
require 'json'
require 'net/http'


def valid_chars(char1, char2)
  if char1.nil? || char2.nil?
    raise("You need to specify TWO character names in the script arguments")
  end
end

def swapi_get(url, search: nil)
  search = search ? "?search=#{search}" : ''
  uri = URI(url + search)
  response = Net::HTTP.get(uri)
  JSON.parse(response, symbolize_names: true)
end

def get_char_films(char)
  response = swapi_get('https://swapi.co/api/people/', search: char)

  if response[:count] == 0
    raise("#{char} is not a character in Star Wars")
  end

  char_films = response[:results][0][:films]
  char_films.map { |url| url.split('/').last }
end

def get_common_films_titles(films1, films2)
  common = films1 & films2
  common.map do |film_id|
    response = swapi_get("https://swapi.co/api/films/#{film_id}/")
    response[:title]
  end
end

def print_titles(titles)
  titles.each do |title|
    puts title
  end
end

if $0 == __FILE__
  char1 = ARGV[0]
  char2 = ARGV[1]

  valid_chars(char1, char2)

  char1_films = get_char_films(char1)
  char2_films = get_char_films(char2)

  common_films_titles = get_common_films_titles(char1_films, char2_films)

  print_titles(common_films_titles)
end