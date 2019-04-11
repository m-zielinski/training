require "rails_helper"

describe Api::V1::MoviesController do
  let!(:movie) { create(:movie) }
  let!(:another_movie) { create(:movie) }

  describe "GET #index" do
    before do
      get :index
    end

    it "returns http success" do
      expect(response).to be_successful
    end

    it "contains expected attributes" do
      expect(response_keys).to match_array(["id", "title"])
    end
  end

  describe "GET #show" do
    before do
      get :show, params: { id: movie.id }
    end

    it "returns http success" do
      expect(response).to be_successful
    end

    it "contains expected attributes" do
      expect(response_keys).to match_array(["id", "title"])
    end
  end

  def response_keys
    json = JSON.parse(response.body)
    return json.first.keys if json.is_a? Array

    json.keys
  end
end
