class AddIndexToSubmits < ActiveRecord::Migration
  def change
    add_index :submits, :task_id
  end
end
