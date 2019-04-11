class MovieImporter
  class << self
    def call(movie)
      response = HTTParty.get(movie_query(movie), format: :json)
      if response.success?
        attr = response.parsed_response["data"]["attributes"]
        movie.plot = attr["plot"]
        movie.rating = attr["rating"]
        movie.poster = attr["poster"]
      else
        raise PairguruAPIException
      end
      movie
    end

    def api_endpoint
      "https://pairguru-api.herokuapp.com/api/v1/"
    end

    def posters_url
      "https://pairguru-api.herokuapp.com/"
    end

    def movie_query(movie)
      api_endpoint + "movies/" + ERB::Util.url_encode(movie.title)
    end
  end
end

class PairguruAPIException < StandardError
  def initialize(msg = "Could not fetch data from Pairguru API")
    super
  end
end
