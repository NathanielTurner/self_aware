json.array!(@stats) do |stat|
  json.extract! stat, :id, :user_id, :nightmare_habit_ratio, :vhard_habit_ratio, :hard_habit_ratio, :nomral_habit_ratio, :easy_habit_ratio, :nightmare_todo_ratio, :vhard_todo_ratio, :hard_todo_ratio, :normal_todo_ratio, :easy_todo_ratio, :best_habit, :worst_habit_string, :best_todo, :worst_todo, :monthly_budget_ratio, :weekly_budget_ratio, :spent_per_day, :most_spent
  json.url stat_url(stat, format: :json)
end
