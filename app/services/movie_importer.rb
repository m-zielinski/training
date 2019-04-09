class MovieImporter
  def self.call(movie)
    response = HTTParty.get(api_endpoint + "movies/" + ERB::Util.url_encode(movie.title))
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

  def self.api_endpoint
    "https://pairguru-api.herokuapp.com/api/v1/"
  end

  def self.posters_url
    "https://pairguru-api.herokuapp.com/"
  end
end

class PairguruAPIException < StandardError
  def initialize(msg = "Could not fetch data from Pairguru API")
    super
  end
end
