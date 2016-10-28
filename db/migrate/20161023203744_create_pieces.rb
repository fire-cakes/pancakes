class CreatePieces < ActiveRecord::Migration
  def change
    create_table :pieces do |t|
      t.integer :player_id
      t.string :type
      t.boolean :color
      t.integer :x_coord
      t.integer :y_coord
      t.boolean :captured
      t.integer :game_id

      t.timestamps
    end
  end
end
