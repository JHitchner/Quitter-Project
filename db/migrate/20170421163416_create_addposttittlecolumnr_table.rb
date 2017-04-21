class CreateAddposttittlecolumnrTable < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :post_title
      t.string :post_body
    end
  end
end
