class RemoveFkAgain < ActiveRecord::Migration[5.0]
  def change
    change_table :users do |t|
      t.remove :profile_id
    end
    change_table :profiles do |t|
      t.remove :post_id
    end
  end
end
