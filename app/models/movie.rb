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

  def fetch_additional_data
    MovieImporter.call(self)
  end

  def poster_url
    MovieImporter.posters_url + poster if poster
  end
end
