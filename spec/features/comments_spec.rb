require "rails_helper"

feature "comments", :js do
  let!(:movie) { create(:movie, title: "Godfather") }
  let(:user) { create(:user) }

  before(:each) do
    user.confirm
    sign_in user
    visit "movies/#{movie.id}"
  end

  scenario "user can post his first comment on the movie" do
    post_comment "I'd really like to see this movie!"

    expect(page).to have_content "I'd really like to see this movie!"
  end

  scenario "user tries to post a second comment on the same movie" do
    post_comment "I'd really like to see this movie!"

    visit "movies/#{movie.id}"
    expect(page).not_to have_selector("comment_body")

    Commontator::Comment.last.destroy # better click_link "Delete"

    visit "movies/#{movie.id}"
    post_comment "I tried to watch it and... no, it sucks!"

    expect(page).not_to have_content "I'd really like to see this movie!"
    expect(page).to have_content "I tried to watch it and... no, it sucks!"
  end

  def post_comment(comment)
    fill_in "comment_body", with: comment
    click_on "Post Comment"
  end
end
