class AddDefaultToCaptured < ActiveRecord::Migration
  def change
    change_column_default :pieces, :captured, false
  end
end
