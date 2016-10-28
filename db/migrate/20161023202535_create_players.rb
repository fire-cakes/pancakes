class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :player_id
      t.string :username
      t.string :email

      t.timestamps
    end
  end
end
