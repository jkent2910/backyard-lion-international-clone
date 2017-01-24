require "googleauth"
require "google/api_client"
require "google_drive"

namespace :backyard_lion_international do

  desc "Updates teams from Google spreadsheet"
  task build_teams: :environment do
    spreadsheet_name = "team_information"

    ENV["GOOGLE_APPLICATION_CREDENTIALS"] = Rails.root.join("config", "google_college_credentials.json").to_path
    ENV["SSL_CERT_FILE"] = $LOAD_PATH.grep(/google-api-client/).first + "/cacerts.pem"

    credentials = Google::Auth.get_application_default
    credentials.scope = ["https://www.googleapis.com/auth/drive", "https://spreadsheets.google.com/feeds/"]
    credentials.fetch_access_token!
    access_token = credentials.access_token

    drive_session = GoogleDrive.login_with_oauth(access_token)

    spreadsheet = drive_session.spreadsheet_by_title(spreadsheet_name)
    raise "Spreadsheet #{spreadsheet_name} not found" unless spreadsheet

    worksheet = spreadsheet.worksheets.first

    attrs = worksheet.rows.first.map(&:to_sym)

    worksheet.rows.drop(1).each do |row|
      team_attrs = attrs.zip(row).to_h
      team = Team.create(id: team_attrs[:id], sport: team_attrs[:sport], country: team_attrs[:country], team_name: team_attrs[:team_name],
                  website: team_attrs[:website], address: team_attrs[:address], gender: 2)

      puts "Creating #{team.team_name}"

      unless team_attrs[:email].nil?
        contact = TeamContact.create(team_id: team.id, email: team_attrs[:email])

        puts "Creating contact #{contact.email}"
      end


    end
  end
end