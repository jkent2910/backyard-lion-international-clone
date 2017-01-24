class AddCustomerIdToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :customer_id, :integer
  end
end
