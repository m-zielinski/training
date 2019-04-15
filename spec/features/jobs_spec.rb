require "rails_helper"

feature "time-consuming job" do
  let!(:movie) { create(:movie) }
  let(:export_file_name) { "tmp/movies.csv" }

  before(:each) do
    user = create(:user)
    user.confirm
    sign_in user
    clear_sent_mailbox
  end

  scenario "when user exports movies to CSV" do
    visit root_path
    remove_export_file
    start_measuring_time
    click_link("Export")

    expect(page).to have_text "Export scheduled"
    expect(seconds_measured).to be < 5 # MovieExporter is hardcoded to take more

    sleep 6
    expect(export_file_created?).to be true
    expect(last_message_sent_subject).to include("Your export is ready")
  end

  scenario "when user requests details e-mailed" do
    visit "movies/#{movie.id}"
    start_measuring_time
    click_link("Email me details about this movie")

    expect(page).to have_text "Email with movie info scheduled"
    expect(seconds_measured).to be < 3 # MovieInfoMailer is hardcoded to take more

    sleep 4
    expect(last_message_sent_subject).to include("Info about movie")
  end

  def start_measuring_time
    @start = Time.current
  end

  def seconds_measured
    Time.current - @start
  end

  def remove_export_file
    FileUtils.rm export_file_name if export_file_created?
  end

  def export_file_created?
    File.exists? export_file_name
  end
end
