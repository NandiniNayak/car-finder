class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.text :comment
      t.references :seller, foreign_key: true
      t.references :buyer, foreign_key: true

      t.timestamps
    end
  end
end
