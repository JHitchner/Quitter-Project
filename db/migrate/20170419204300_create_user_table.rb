class CreateUserTable < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |user|
      user.string :username
      user.string :password
    end
  end
end
