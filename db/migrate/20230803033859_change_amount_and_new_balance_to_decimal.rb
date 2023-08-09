# db/migrate/20230802093645_change_amount_and_new_balance_to_decimal.rb
class ChangeAmountAndNewBalanceToDecimal < ActiveRecord::Migration[7.0]
  def change
    change_column :transactions, :amount, :decimal, precision: 10, scale: 2, null: false
    change_column :transactions, :new_balance, :decimal, precision: 10, scale: 2, null: false
  end
end
