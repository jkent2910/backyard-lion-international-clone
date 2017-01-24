class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_mailbox
  before_action :get_conversation, except: [:index, :empty_trash, :render_new_message]
  before_action :get_box, only: [:index]
  before_action :check_message_count, only: [:reply]

  def index
    if @box.eql? "inbox"
      @conversations = @mailbox.inbox
    elsif @box.eql? "sent"
      @conversations = @mailbox.sentbox
    else
      @conversations = @mailbox.trash
    end
    @conversation = @mailbox.conversations.first rescue nil

    @conversations = @conversations.paginate(page: params[:page], per_page: 10)

    if params[:to].nil?
      @chosen_recipient = nil
    else
      @chosen_recipient = User.find_by(id: params[:to].to_i) if params[:to]
    end
  end

  def render_conversation
    respond_to do |format|
      format.html
      format.js
    end
  end

  def render_new_message
    respond_to do |format|
      format.html
      format.js
    end
  end

  def render_message_modal
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
  end

  def reply
    current_user.reply_to_conversation(@conversation, params[:body])

    # Update message_count
    message_count = current_user.message_count
    current_user.update_attributes(message_count: message_count + 1)

    flash[:success] = 'Reply sent'
    redirect_to conversations_path
  end

  def destroy
    @conversation.move_to_trash(current_user)
    flash[:success] = 'The conversation was moved to trash.'
    redirect_to conversations_path
  end

  def restore
    @conversation.untrash(current_user)
    flash[:success] = 'The conversation was restored.'
    redirect_to conversations_path
  end

  def empty_trash
    @mailbox.trash.each do |conversation|
      conversation.receipts_for(current_user).update_all(deleted: true)
    end
    flash[:success] = 'Your trash was cleaned!'
    redirect_to conversations_path
  end

  def mark_as_read
    @conversation.mark_as_read(current_user)
    flash[:success] = 'The conversation was marked as read.'
    redirect_to conversations_path
  end

  private

  def get_mailbox
    @mailbox ||= current_user.mailbox
  end

  def get_conversation
    @conversation ||= @mailbox.conversations.find(params[:id])
  end

  def get_box
    if params[:box].blank? or !["inbox","sent","trash"].include?(params[:box])
      params[:box] = 'inbox'
    end
    @box = params[:box]
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