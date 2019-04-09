WebMock.allow_net_connect!

RSpec.configure do |config|
  config.before(:each) do
    # unavailable movie request
    stub_request(:get, MovieImporter.api_endpoint + "movies/Inception%20II%20-%20Dreaming%20about%20a%20totem")
      .with(
        headers: {
          "Accept": "application/json",
          "Accept-Encoding": "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
          "User-Agent": "Ruby"
        }
      )
      .to_return(status: 404, body: { "message": "Couldn't find Movie" }.to_json, headers: {})

    # correct movie request
    stub_request(:get, Regexp.new(MovieImporter.api_endpoint + "movies/"))
      .with(
        headers: {
          "Accept": "application/json",
          "Accept-Encoding": "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
          "User-Agent": "Ruby"
        }
      )
      .to_return(status: 200, body: { "data": { "id": "6", "type": "movie", "attributes": { "title": "Godfather", "plot": "The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.", "rating": 9.2, "poster": "/godfather.jpg" } } }.to_json, headers: {})
  end
end
