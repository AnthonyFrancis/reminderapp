class AddToToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :to, :string
  end
end
