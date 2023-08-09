class HomeController < ApplicationController
  before_action :authenticate_employee!

  def index
    @transactions = Transaction.all
    @users = User.all
    @total_balance = User.sum(:current_balance)
    @total_credit_amount = Transaction.where(transaction_type: 'credit').sum(:amount)
    @total_debit_amount = Transaction.where(transaction_type: 'debit').sum(:amount)
    @employee = current_employee
    @first_name = @employee.first_name
    @last_name = @employee.last_name    
    @cpf = @employee.cpf
    @email = @employee.email
  end
end
