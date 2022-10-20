class CreateDislikes < ActiveRecord::Migration[7.0]
  def change
    create_table :dislikes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :article, null: false, foreign_key: true

      t.timestamps
    end
    add_index :dislikes, [:user_id, :article_id], unique: true
  end
end
