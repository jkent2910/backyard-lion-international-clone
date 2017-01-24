class SubscriptionsController < ApplicationController

  before_filter :authenticate_user!

  def new
    @stripe_list = Stripe::Plan.all
    @plans = @stripe_list[:data]
    @subscription = Subscription.new
  end

  def create
    @subscription = Subscription.new(subscription_params)

    @subscription.user = current_user

    plan = Stripe::Plan.retrieve(params[:subscription][:plan_id])

    respond_to do |format|
      if @subscription.save

        if plan.id == 'byl-intl-silver'
          @subscription.update_attributes(subscription_level: "silver_monthly")
        elsif plan.id  == 'byl-intl-gold'
          @subscription.update_attributes(subscription_level: "gold_monthly")
        elsif plan.id == 'byl-intl-platinum'
          @subscription.update_attributes(subscription_level: "platinum_monthly")
        elsif plan.id == 'byl-intl-silver-annual'
          @subscription.update_attributes(subscription_level: "silver_annually")
        elsif plan.id == 'byl-intl-gold-annual'
          @subscription.update_attributes(subscription_level: "gold_annually")
        elsif plan.id == 'byl-intl-platinum-annual'
          @subscription.update_attributes(subscription_level:"platinum_annually")
        end

        # Create the customer
        customer = Stripe::Customer.create(
            :email => current_user.email,
            :source => params[:stripeToken])

        # Create the subscription
        Stripe::Subscription.create(
            :customer => customer.id,
            :plan => plan)

        user = User.find(current_user.id)
        user.update_attributes(paid_subscription: true)

        @subscription.update_attributes(customer_id: customer.id)

        AdminMailer.paid_subscription_notification(user, @subscription.subscription_level).deliver_later

        format.html { redirect_to root_path, notice: "Subscription processed!  Welcome aboard!"}
      else
        format.html { render :new }
      end
    end

  end

  def edit
    @subscription = Subscription.find(params[:id])
  end

  def destroy
    @subscription = Subscription.find(params[:id])

    customer = Stripe::Customer.retrieve(@subscription.customer_id.to_s)
    subscription = customer.subscriptions.first.id

    subscription_object = Stripe::Subscription.retrieve(subscription)

    subscription_object.delete

    user = User.find(@subscription.user_id)
    user.update_attributes(paid_subscription: false)

    @subscription.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: "Subscription deleted" }
      format.json { head :no_content }
    end
  end

  private
  def subscription_params
    params.require(:subscription).permit(:user_id, :subscription_level)
  end


end