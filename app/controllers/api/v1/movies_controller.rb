module Api
  module V1
    class MoviesController < ActionController::API
      def index
        render json: Movie.all.map(&:basic_data)
      end

      def show
        render json: Movie.find(params[:id].to_i).basic_data
      end
    end
  end
end
