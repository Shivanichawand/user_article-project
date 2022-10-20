class CreateListings < ActiveRecord::Migration[7.0]
  def change
    create_table :listings do |t|
      t.references :user
      t.references :like
      t.references :dislike
      t.timestamps
    end
  end
end
