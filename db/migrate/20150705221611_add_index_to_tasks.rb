class AddIndexToTasks < ActiveRecord::Migration
  def change
    add_index :tasks, :user_id
    add_index :tasks, :style
  end
end
