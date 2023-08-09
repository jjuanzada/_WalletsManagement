module UsersHelper
    def format_cpf(cpf)
      return '' unless cpf
  
      # Remove caracteres não numéricos do CPF, caso existam
      cpf = cpf.gsub(/\D/, '')
  
      # Formata o CPF no padrão xxx.xxx.xxx-xx
      cpf = "#{cpf[0..2]}.#{cpf[3..5]}.#{cpf[6..8]}-#{cpf[9..10]}"
    end
  end
  