require "rails_helper"
require 'rake'

feature "top commenters", :js do
  let!(:movies) { create_list(:movie, 15) }
  let(:active_user) { create(:user, name: 'Super Active') }
  let(:average_users) { create_list(:user, 9) }
  let(:lazy_user) { create(:user, name: 'Lazy As Hell') }

  scenario "show actual top 10 of commenters" do
    active_user
    average_users
    create_comments
    lazy_user # did nothing

    visit '/top_commenters'

    expect(page).to have_content "Top Commenters this week"
    expect(page).to have_content "Super Active"
    expect(page).not_to have_content "Lazy As Hell"

    average_users.each do |user|
      expect(active_user.name).to appear_before(user.name)
    end
    expect(page).not_to have_content "Lazy As Hell"
  end

  def create_comments
    Commontator::Thread.destroy_all
    Commontator::Comment.destroy_all

    Movie.all.each do |movie|
      Commontator::Thread.create!(
        commontable_type: "Movie",
        commontable_id: movie.id
      )
    end

    Commontator::Thread.all.each do |thread|
      create_comment(active_user, thread)
      average_users.each do |user|
        create_comment(user, thread) if rand(10) == 0
      end
    end
  end

  def create_comment(user, thread)
    Commontator::Comment.create!(
      thread_id: thread.id,
      creator_type: "User",
      creator_id: user.id,
      body: Faker::Movie.quote
    )
  end

  RSpec::Matchers.define :appear_before do |later_content|
    match do |earlier_content|
      page.body.index(earlier_content) < page.body.index(later_content)
    end
  end
end
