class ChangeReferencesToNotNull < ActiveRecord::Migration[6.1]
  def change
    change_column_null :items, :todo_id, true
  end
end
