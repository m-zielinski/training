WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.before(:each) do
    # correct movie request
    stub_request(:get, Addressable::Template.new(MovieImporter.api_endpoint + "movies/{title}"))
      .with(
        headers: {
          "Accept" => "*/*",
          "Accept-Encoding": "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
          "User-Agent": "Ruby"
        }
      )
      .to_return(status: 200,
        body: { "data": { "id": "1", "type": "movie", "attributes": FactoryBot.attributes_for(:full_movie_data) } }.to_json,
        headers: {}
      )

    # unavailable movie request
    stub_request(:get, MovieImporter.api_endpoint + "movies/Inception%20II%20-%20Dreaming%20about%20a%20totem")
      .with(
        headers: {
          "Accept" => "*/*",
          "Accept-Encoding": "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
          "User-Agent": "Ruby"
        }
      )
      .to_return(status: 404, body: { "message": "Couldn't find Movie" }.to_json, headers: {})
  end
end
