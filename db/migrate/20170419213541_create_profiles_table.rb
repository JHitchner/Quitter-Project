class CreateProfilesTable < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |table|
      table.string :fname
      table.string :lname
      table.string :email
      table.datetime :bday
      table.text :bio
      table.string :profile_img
      table.integer :user_id
      table.integer :post_id
    end
  end
end
