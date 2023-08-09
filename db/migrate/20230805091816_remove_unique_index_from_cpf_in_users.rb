class RemoveUniqueIndexFromCpfInUsers < ActiveRecord::Migration[7.0]
  def change
    remove_index :users, :cpf
  end
end
