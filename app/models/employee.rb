class Employee < ApplicationRecord
  has_many :transactions

  before_save :format_cpf
  validates :cpf, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  private

  def format_cpf
    self.cpf&.gsub!(/[^0-9]/, '')
  end
end
