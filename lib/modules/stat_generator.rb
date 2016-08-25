require_relative '../../app/helpers/tasks_helper'
require_relative '../../app/helpers/budgets_helper'
include TasksHelper
include BudgetsHelper

module StatGenerator

	def calculate_stats(user)
		stat = user.stat
		budgets = user.budgets
		withdrawals = user.withdrawals
		tasks = user.tasks
		habits = tasks.where(style: 'habit')
		todos = tasks.where(style: 'to_do')
		nightmare_habits = habits.where(difficulty: 'nightmarish')
		vhard_habits = habits.where(difficulty: 'very hard')
		hard_habits = habits.where(difficulty: 'hard')
		normal_habits = habits.where(difficulty: 'normal')
		easy_habits = habits.where(difficulty: 'easy')
		nightmare_todos = todos.where(difficulty: 'nightmarish')
		vhard_todos = todos.where(difficulty: 'very hard')
		hard_todos = todos.where(difficulty: 'hard')
		normal_todos = todos.where(difficulty: 'normal')
		easy_todos = todos.where(difficulty: 'easy')
		monthly_budgets = budgets.where(monthly_limit: true)
		weekly_budgets = budgets.where(weekly_limit: true)
		stat.best_habit = habits.order(consecutive_submits: :desc).first.title
		stat.worst_habit = habits.order(consecutive_submits: :asc).first.title
		stat.best_to_do_difficulty = good_to_dos(todos)
		stat.worst_to_do_difficulty = bad_to_dos(todos)
		stat.best_habit_difficulty = good_habits(habits)
		stat.worst_habit_difficulty = bad_habits(habits)
		stat.spent_per_day = average_spent_daily(withdrawals.order(amount: :desc))
		stat.most_spent = user.withdrawals.order(amount: :desc).first.amount
		stat.save
	end

end
