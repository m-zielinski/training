require "rails_helper"

describe Api::V2::MoviesController do
  let!(:genre) { create(:genre) }
  let!(:movies) { create_list(:movie, 2, genre: genre) }

  describe "GET #index" do
    before do
      get :index
    end

    it "returns http success" do
      expect(response).to be_successful
    end

    it "contains expected attributes" do
      expect(sample_record.keys).to match_array(["id", "title", "genre"])
      expect(genre_details.keys).to match_array(["id", "name", "number_of_movies"])
      expect(genre_details["name"]).to eq genre.name
    end
  end

  describe "GET #show" do
    before do
      get :show, params: { id: movies.first.id }
    end

    it "returns http success" do
      expect(response).to be_successful
    end

    it "contains expected attributes" do
      expect(sample_record.keys).to match_array(["id", "title", "genre"])
      expect(genre_details.keys).to match_array(["id", "name", "number_of_movies"])
      expect(genre_details["name"]).to eq genre.name
    end
  end

  def sample_record
    @json ||= JSON.parse(response.body)
    return @json.last if @json.is_a? Array

    @json
  end

  def genre_details
    sample_record["genre"]
  end
end
