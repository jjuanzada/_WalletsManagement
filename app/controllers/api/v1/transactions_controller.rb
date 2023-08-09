module Api
  module V1
    class TransactionsController < ApplicationController
      before_action :authenticate_employee!
      before_action :set_user, only: %i[credit debit balance transactions]
      
      # POST /api/v1/users/:user_id/transactions/credit
      # Credit an amount to the user's virtual wallet.
      def credit
        amount = params[:amount].to_f
        if amount <= 0
          render json: { error: 'Amount must be greater than 0.' }, status: :unprocessable_entity
          return
        end

        @user.current_balance += amount
        if @user.save
          create_transaction('credit', amount, @user.current_balance, current_employee)
          render json: { message: 'Credit transaction successful.', balance: @user.current_balance }
        else
          render json: { error: 'Failed to save the user.' }, status: :unprocessable_entity
        end
      end
      
      # POST /api/v1/users/:user_id/transactions/debit
      # Debit an amount from the user's virtual wallet.
      def debit
        amount = params[:amount].to_f
        if amount <= 0 || @user.current_balance < amount
          render json: { error: 'Invalid amount or insufficient balance.' }, status: :unprocessable_entity
          return
        end

        @user.current_balance -= amount
        if @user.save
          create_transaction('debit', amount, @user.current_balance, current_employee)
          render json: { message: 'Debit transaction successful.', balance: @user.current_balance }
        else
          render json: { error: 'Failed to save the user.' }, status: :unprocessable_entity
        end
      end
      
      # GET /api/v1/users/:user_id/transactions/balance
      # Retrieve the current balance of the user's virtual wallet.
      def balance
        render json: { balance: @user.current_balance }
      end

      # GET /api/v1/users/:user_id/transactions
      # Retrieve transactions for a specific user within a specified time period.
      def transactions
        start_date = params[:start_date].to_date
        end_date = params[:end_date].to_date

        transactions = @user.transactions.where(created_at: start_date.beginning_of_day..end_date.end_of_day)

        render json: { transactions: transactions }
      end

      # GET /api/v1/transactions
      # Retrieve all transactions across all users in a specified time period.
      def all_transactions
        start_date = params[:transaction_date_start]&.to_date
        end_date = params[:transaction_date_end]&.to_date
        cpf = params[:cpf]
        employee = params[:employee]
        transaction_type = params[:transaction_type_eq]
      
        @transactions = if start_date.present? && end_date.present?
                          Transaction.where(created_at: start_date.beginning_of_day..end_date.end_of_day)
                        else
                          Transaction.all
                        end
      
        @transactions = @transactions.where(user_id: User.find_by(cpf: cpf)&.id) if cpf.present?
        @transactions = @transactions.where(employee_id: Employee.find_by(email: employee)&.id) if employee.present?
        @transactions = @transactions.where(transaction_type: params[:transaction_type_eq]) if transaction_type.present?
      
        respond_to do |format|
          format.html { render 'index' }
          format.json { render json: { transactions: @transactions } }
        end
      end

      private

      def set_user
        @user = User.find(params[:user_id])
      end

      def create_transaction(transaction_type, amount, new_balance, employee)
        @user.transactions.create!(
          transaction_type: transaction_type,
          amount: amount,
          new_balance: new_balance,
          employee: employee
        )
      end
    end
  end
end