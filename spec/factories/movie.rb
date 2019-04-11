FactoryBot.define do
  factory :movie do
    title { Faker::Lorem.word }
    description { Faker::Lorem.sentence(3, true) }
    released_at { Faker::Date.between(40.years.ago, Time.zone.today) }
    genre

    factory :full_movie_data do
      title "Godfather"
      plot "The aging patriarch..."
      rating 9.2
      poster "/godfather.jpg"
    end
  end
end
