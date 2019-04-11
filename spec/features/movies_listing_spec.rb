require "rails_helper"

feature "showing movies with full data", :js do
  let!(:movie) { create(:movie, title: "Godfather") }
  let!(:other_movie) { create(:movie, title: "Inglourious Basterds") }

  scenario "in list" do
    visit "/movies"
    wait_for_ajax
    
    expect(page).to have_text("Godfather")
      .and have_text("The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.")
    expect(page).to have_selector(".plot", count: 2)
      .and have_selector(".poster", count: 2)
      .and have_selector(".rating", count: 2)
  end

  scenario "by one" do
    visit "movies/#{movie.id}"

    expect(page).to have_text("Godfather")
      .and have_text("The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.")
    expect(page).to have_selector(".plot")
      .and have_selector(".poster")
      .and have_selector(".rating")
  end
end
