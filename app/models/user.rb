class User < ApplicationRecord
  has_many :transactions, dependent: :destroy
  
  validates :cpf, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  before_destroy :destroy_associated_transactions

  private

  def destroy_associated_transactions
    self.transactions.destroy_all
  end
end
