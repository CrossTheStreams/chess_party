class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.integer :white_user_id
      t.integer :black_user_id
      t.string :fen
      t.timestamps
    end
  end
end
