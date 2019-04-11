require "rails_helper"

describe MovieImporter do
  let(:movie) { create(:movie, title: "Godfather") }
  let(:not_available_movie) { create(:movie, title: "Inception II - Dreaming about a totem") }

  it "fetches data from the Pairguru API correctly" do
    expect(MovieImporter.call(movie)).to be_a Movie
    expect(movie.rating).to eq 9.2
    expect(movie.poster).to eq "/godfather.jpg"
    expect(movie.plot).to eq "The aging patriarch..."
    expect(movie.title).not_to eq "Godfather part II"
  end

  it "throws a custom exception when something goes wrong" do
    expect { MovieImporter.call(not_available_movie) }.to raise_exception PairguruAPIException
  end
end
