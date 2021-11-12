# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "faker"
require "open-uri"
require "json"

puts "Deleting ..."

Movie.destroy_all

url = "http://tmdb.lewagon.com/movie/top_rated"

puts "Creating ..."
50.times do |i|
  movies = JSON.parse(URI.open("#{url}?page=#{i + 1}").read)['results']
  movies.each do |movie|
    base_poster_url = "https://image.tmdb.org/t/p/original"
    unless Movie.where(title: movie['title']).exists?
    Movie.create!(
    title: movie['title'],
    overview: movie['overview'],
    poster_url:"#{base_poster_url}#{movie['backdrop_path']}",
    rating: movie['vote_average'])
    end
  end
end

puts "Done...."
