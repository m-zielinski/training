namespace :comments do
  task remove: :environment do
    Commontator::Thread.destroy_all
    Commontator::Comment.destroy_all
  end

  task create: :environment do
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
  end
end
