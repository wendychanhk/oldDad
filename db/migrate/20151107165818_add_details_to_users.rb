class AddDetailsToUsers < ActiveRecord::Migration
  def change
  add_column :users, :first_name, :string
  add_column :users, :last_name, :string
  add_column :users, :introduction, :text
  add_column :users, :city, :string
  add_column :users, :country_code, :string
  add_column :users, :interest, :text, array: true, default: []
  add_column :users, :birthday, :datetime
  end
end
