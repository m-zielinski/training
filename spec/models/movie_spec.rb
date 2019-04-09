require "rails_helper"

describe Movie do
  let(:movie) { create(:movie, title: "Godfather") }

  it "has all the needed information, some of them, after fetching" do
    expect(basic_fields).to all be_present

    movie.fetch_additional_data

    expect(additional_fields).to all be_present
  end

  def basic_fields
    %w[title description released_at genre].map{ |f| movie.send(f) }
  end

  def additional_fields
    %w[rating plot poster].map{ |f| movie.send(f) }
  end

  def field(field_name)
    movie.call_method(field_name)
  end
end
