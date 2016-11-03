# frozen_string_literal: true
class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :users_id
      t.string :name
      t.integer :player_id
      t.integer :white_player_id
      t.integer :black_player_id
      t.integer :winner_player_id
      t.integer :status

      t.timestamps
    end
  end
end
