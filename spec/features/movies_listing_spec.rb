require "rails_helper"

feature "showing movies with full data", :js do
  let!(:movie) { create(:movie, title: "Godfather") }

  scenario "in list" do
    visit "/movies"

    expect_additional_fields_on_page

    wait_for_ajax
    expect_to_see_full_movie_data
  end

  scenario "by one" do
    visit "movies/#{movie.id}"

    expect_additional_fields_on_page
    expect_to_see_full_movie_data
  end

  def expect_to_see_full_movie_data
    expect(page).to have_text("Godfather")
      .and have_text("The aging patriarch...")
      .and have_text("9.2")
    expect(page.find(".poster", match: :first)["src"]).to have_content "godfather.jpg"
  end

  def expect_additional_fields_on_page
    expect(page).to have_selector(".plot")
      .and have_selector(".poster")
      .and have_selector(".rating")
  end
end
