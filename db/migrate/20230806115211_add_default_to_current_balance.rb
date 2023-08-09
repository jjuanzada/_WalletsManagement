class AddDefaultToCurrentBalance < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :current_balance, 0
  end
end
