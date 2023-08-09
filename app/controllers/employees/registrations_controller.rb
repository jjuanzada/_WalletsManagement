# app/controllers/employees/registrations_controller.rb
class Employees::RegistrationsController < Devise::RegistrationsController
    private
  
    # Sobrescreva o método que permite os parâmetros personalizados (como first_name e last_name).
    def sign_up_params
      params.require(:employee).permit(:email, :password, :password_confirmation, :first_name, :last_name, :cpf)
    end
  
    # Sobrescreva o método que permite a atualização dos parâmetros personalizados.
    def account_update_params
      params.require(:employee).permit(:email, :password, :password_confirmation, :current_password, :first_name, :last_name, :cpf)
    end
  end
  