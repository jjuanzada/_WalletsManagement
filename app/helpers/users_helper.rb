module UsersHelper
    def format_cpf(cpf)
      return '' unless cpf
  
      # Remove non-numeric characters from CPF
      cpf = cpf.gsub(/\D/, '')
  
      # Format CPF xxx.xxx.xxx-xx
      cpf = "#{cpf[0..2]}.#{cpf[3..5]}.#{cpf[6..8]}-#{cpf[9..10]}"
    end
  end
  