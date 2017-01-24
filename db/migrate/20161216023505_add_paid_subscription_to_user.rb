class AddPaidSubscriptionToUser < ActiveRecord::Migration
  def change
    add_column :users, :paid_subscription, :boolean, default: false, null: false
  end
end
