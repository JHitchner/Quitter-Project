class RemoveProfFromPost < ActiveRecord::Migration[5.0]
  def change
    change_table :posts do |t|
      t.remove :profile_id
    end
  end
end
