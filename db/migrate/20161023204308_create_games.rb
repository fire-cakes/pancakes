class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :id
      t.integer :white_id
      t.integer :black_id
      t.integer :winner_id
      t.integer :status

      t.timestamps
    end
  end
end
