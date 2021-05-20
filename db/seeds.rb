# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Clearing database...'

List.destroy_all

puts 'Seeding...'
url = 'http://tmdb.lewagon.com/movie/top_rated'

json = JSON.parse(URI.open(url).read)

json['results'].each do |result|
  Movie.create(title: result['title'], overview: result['overview'], rating: result['vote_average'], poster_url: "https://image.tmdb.org/t/p/w400#{result['poster_path']}") # {result['overview']} Rating: #{result['vote_average']}"
end

puts 'Seeded!'
