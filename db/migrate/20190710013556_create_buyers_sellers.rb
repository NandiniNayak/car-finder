class CreateBuyersSellers < ActiveRecord::Migration[5.2]
  def change
    create_table :buyers_sellers do |t|
      t.references :buyer, foreign_key: true
      t.references :seller, foreign_key: true

      t.timestamps
    end
  end
end
