# == Schema Information
#
# Table name: movies
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  released_at :datetime
#  avatar      :string
#  genre_id    :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Movie < ApplicationRecord
  belongs_to :genre
  attr_accessor :rating, :plot, :poster

  validates_with TitleBracketsValidator

  acts_as_commontable dependent: :destroy

  def fetch_additional_data
    MovieImporter.call(self)
  end

  def poster_url
    MovieImporter.posters_url + poster if poster
  end

  def basic_data
    { id: id, title: title }
  end

  def with_genre_counts(genre_counts = {})
    {
      id: id, title: title,
      genre: { id: genre_id, name: genre.name, number_of_movies: genre_counts[genre_id] }
    }
  end
end
