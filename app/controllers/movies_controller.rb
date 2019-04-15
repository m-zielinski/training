class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info, :export]

  def index
    @movies = Movie.all.decorate
  rescue PairguruAPIException
  end

  def show
    @movie = Movie.find(params[:id]).fetch_additional_data.decorate
  rescue PairguruAPIException
  end

  def send_info
    @movie = Movie.find(params[:id])
    MovieInfoMailerJob.perform_later(current_user, @movie)
    redirect_back(fallback_location: root_path, notice: "Email with movie info scheduled")
  end

  def fetch_additional_data
    @movie = Movie.find(params[:id]).fetch_additional_data
    render json: { plot: @movie.plot, rating: @movie.rating, poster: @movie.poster_url }
  end

  def export
    file_path = "tmp/movies.csv"
    MovieExporterJob.perform_later(current_user, file_path)
    redirect_to root_path, notice: "Export scheduled"
  end
end
