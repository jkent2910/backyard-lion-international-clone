class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_message_count, only: [:create]

  def new
    if params[:to].nil?
      @chosen_recipient = nil
    else
      @chosen_recipient = User.find_by(id: params[:to].to_i) if params[:to]
    end
  end

  def create
    recipients = User.where(id: params['recipients'])

    if !params[:recipient].nil? && params['recipients'].nil?
      recipients = User.where(id: params[:recipient])
    end

    conversation = current_user.send_message(recipients, params[:message][:body], params[:message][:subject]).conversation

    # Update message_count
    message_count = current_user.message_count
    current_user.update_attributes(message_count: message_count + 1)

    flash[:success] = "Message has been sent!"
    redirect_to conversations_path
  end

  private

  def check_message_count
    unless current_user.paid_subscription?
      if current_user.message_count > 3
        redirect_to root_path, notice: "
          <div class='col-sm-6 col-md-offset-4 col-md-4'>
            <div class='list-group-item top-add-on text-center text-uppercase'>
              <span style='font-size: inherit;font-weight: bold; color:#d9534f;'>Your Daily Message Limit Reached</span>
            </div>
            <div class='connector-top thumbnail text-center' style='padding-top: 20px;'>
              <p style='vertical-align: baseline; font-size:18px'>Time to next message</p>
              <h1 style='color:#d9534f; padding-right:1px !important;'>12:01 <small>am</small</h1>
              <p style='vertical-align: baseline; font-size:18px'><br> or <br></p>
              <div class='caption'>

                <a href='#{premium_user_path}' class='btn btn-default btn-success'>Try Premium
                  <span class='label label-danger'> SALE</span>
                </a>
              </div>
            </div>
          </div>
          "
      end
    end
  end

end