class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :id
      t.string :username
      t.string :email

      t.timestamps
    end
  end
end
