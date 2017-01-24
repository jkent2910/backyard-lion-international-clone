require "googleauth"
require "google/api_client"
require "google_drive"

namespace :backyard_lion_international do

  desc "Sends athlete invites from Google spreadsheet"
  task send_invites: :environment do
    spreadsheet_name = "football_athletes"

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
      invite_attrs = attrs.zip(row).to_h
      InviteMailer.invite_email(invite_attrs[:first_name], invite_attrs[:last_name], invite_attrs[:high_school],
                               invite_attrs[:email]).deliver_later
    end
  end


  desc "Sends coach invites from Google spreadsheet"
  task send_coach_invites: :environment do
    spreadsheet_name = "coach_invites"

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
      invite_attrs = attrs.zip(row).to_h
      unless invite_attrs[:email].blank?
        InviteMailer.coach_invite_email(invite_attrs[:email], invite_attrs[:athlete_school], invite_attrs[:name]).deliver_later
      end
    end
  end
end