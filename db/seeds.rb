require "faker"

Rails.logger = Logger.new(STDOUT)

Rails.logger.info "Creating users..."

15.times do |i|
  number = i.zero? ? "" : i + 1
  name = Faker::Name.name
  email = Faker::Internet.email
  next if User.exists?(email: email)
  User.create!(
    email: email,
    name: name,
    confirmed_at: Time.zone.now,
    password: "password"
  )
end

Rails.logger.info "Creating genres..."

%w(Action Comedy Sci-Fi War Crime
   Horror Sport Western Drama
   Musicial Romance Thriller).each do |genre|
  Genre.find_or_create_by!(name: genre)
end

movies = [
  {
    title: "Pulp Fiction",
    release_year: "1994"
  },
  {
    title: "Django",
    release_year: "2012"
  },
  {
    title: "Kill Bill",
    release_year: "2003"
  },
  {
    title: "Kill Bill 2",
    release_year: "2004"
  },
  {
    title: "Inglourious Basterds",
    release_year: "2009"
  },
  {
    title: "Godfather",
    release_year: "1972"
  },
  {
    title: "The Dark Knight",
    release_year: "2008"
  },
  {
    title: "Star Wars V",
    release_year: "1980"
  },
  {
    title: "Inception",
    release_year: "2010"
  },
  {
    title: "Deadpool",
    release_year: "2016"
  }
]

Rails.logger.info "Creating movies..."

genre_ids = Genre.pluck(:id)
if Movie.count < 100
  20.times do
    movie = movies.sample
    Movie.create!(
      title: movie[:title],
      description: Faker::Lorem.paragraph(5),
      genre_id: genre_ids.sample,
      released_at: Date.new(movie[:release_year].to_i)
    )
  end
end

Rails.logger.info "Creating comments..."

Commontator::Thread.destroy_all
Commontator::Comment.destroy_all

Movie.all.each do |movie|
  Commontator::Thread.create!(
    commontable_type: "Movie",
    commontable_id: movie.id
  )
end

User.all.each do |user|
  lazyness = rand(Commontator::Thread.count)
  Commontator::Thread.all.each do |thread|
    willing_to_comment = (rand(lazyness + 1) == 0)
    Commontator::Comment.create!(
      thread_id: thread.id,
      creator_type: "User",
      creator_id: user.id,
      body: Faker::Movie.quote
    ) if willing_to_comment
  end
end
