class AddSessionTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :session_token, :string
    change_column_null :users, :session_token, false
  end
end
