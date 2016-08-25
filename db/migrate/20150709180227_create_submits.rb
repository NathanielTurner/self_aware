class CreateSubmits < ActiveRecord::Migration
  def change
    create_table :submits do |t|
      t.integer :user_id
      t.integer :task_id
      t.boolean :on_time
      t.string  :week_day
      t.boolean :on_repeat

      t.timestamps null: false
    end
  end
end
