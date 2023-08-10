class Employees::RegistrationsController < Devise::RegistrationsController
    private
  
    def sign_up_params
      params.require(:employee).permit(:email, :password, :password_confirmation, :first_name, :last_name, :cpf)
    end

    def account_update_params
      params.require(:employee).permit(:email, :password, :password_confirmation, :current_password, :first_name, :last_name, :cpf)
    end
  end
  