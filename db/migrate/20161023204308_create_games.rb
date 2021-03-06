# frozen_string_literal: true
class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.integer :white_player_id
      t.integer :black_player_id
      t.integer :status

      t.timestamps
    end
  end
end
