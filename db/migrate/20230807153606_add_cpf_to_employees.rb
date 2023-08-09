class AddCpfToEmployees < ActiveRecord::Migration[7.0]
  def change
    add_column :employees, :cpf, :string
  end
end
