class Transaction < ApplicationRecord
    belongs_to :user
    belongs_to :employee
    
    validates :cpf, presence: true
    validates :first_name, presence: true
    validates :last_name, presence: true
  
    def self.filter_by_date_and_user(start_date, end_date, user_id)
      where("transaction_date >= ? AND transaction_date <= ? AND user_id = ?", start_date, end_date, user_id)
    end
  end
  