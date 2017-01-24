class ChangeCustomerId < ActiveRecord::Migration
  def change
    change_column :subscriptions, :customer_id, :string
  end
end
