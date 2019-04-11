module Api
  module V2
    class MoviesController < ActionController::API
      def index
        genre_counts = Genre.joins(:movies).group("movies.genre_id").count
        render json: Movie.includes(:genre).map { |movie| movie.with_genre_counts(genre_counts) }
      end

      def show
        movie = Movie.find(params[:id].to_i)
        genre_count = Genre.joins(:movies).where(genres: { id: movie.genre_id }).count
        render json: movie.with_genre_counts(movie.genre_id => genre_count)
      end
    end
  end
end
