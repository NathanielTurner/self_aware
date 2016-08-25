class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.integer :user_id
      t.integer :nightmare_habit_ratio,       default: 0
      t.integer :vhard_habit_ratio,           default: 0
      t.integer :hard_habit_ratio,            default: 0
      t.integer :nomral_habit_ratio,          default: 0
      t.integer :easy_habit_ratio,            default: 0
      t.integer :nightmare_todo_ratio,        default: 0
      t.integer :vhard_todo_ratio,            default: 0
      t.integer :hard_todo_ratio,             default: 0
      t.integer :normal_todo_ratio,           default: 0
      t.integer :easy_todo_ratio,             default: 0
      t.integer :monthly_budget_ratio,        default: 0
      t.integer :weekly_budget_ratio,         default: 0
      t.decimal :spent_per_day,               default: 0
      t.float :most_spent,                    default: 0
      t.string :best_habit
      t.string :worst_habit
      t.string :best_to_do_difficulty
      t.string :worst_to_do_difficulty
      t.string :best_habit_difficulty
      t.string :worst_habit_difficulty


      t.timestamps null: false
    end
  end
end
