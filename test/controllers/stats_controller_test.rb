require "test_helper"

class StatsControllerTest < ActionController::TestCase
  def stat
    @stat ||= stats :one
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:stats)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference("Stat.count") do
      post :create, stat: { best_habit: stat.best_habit, best_todo: stat.best_todo, easy_habit_ratio: stat.easy_habit_ratio, easy_todo_ratio: stat.easy_todo_ratio, hard_habit_ratio: stat.hard_habit_ratio, hard_todo_ratio: stat.hard_todo_ratio, monthly_budget_ratio: stat.monthly_budget_ratio, most_spent: stat.most_spent, nightmare_habit_ratio: stat.nightmare_habit_ratio, nightmare_todo_ratio: stat.nightmare_todo_ratio, nomral_habit_ratio: stat.nomral_habit_ratio, normal_todo_ratio: stat.normal_todo_ratio, spent_per_day: stat.spent_per_day, user_id: stat.user_id, vhard_habit_ratio: stat.vhard_habit_ratio, vhard_todo_ratio: stat.vhard_todo_ratio, weekly_budget_ratio: stat.weekly_budget_ratio, worst_habit_string: stat.worst_habit_string, worst_todo: stat.worst_todo }
    end

    assert_redirected_to stat_path(assigns(:stat))
  end

  def test_show
    get :show, id: stat
    assert_response :success
  end

  def test_edit
    get :edit, id: stat
    assert_response :success
  end

  def test_update
    put :update, id: stat, stat: { best_habit: stat.best_habit, best_todo: stat.best_todo, easy_habit_ratio: stat.easy_habit_ratio, easy_todo_ratio: stat.easy_todo_ratio, hard_habit_ratio: stat.hard_habit_ratio, hard_todo_ratio: stat.hard_todo_ratio, monthly_budget_ratio: stat.monthly_budget_ratio, most_spent: stat.most_spent, nightmare_habit_ratio: stat.nightmare_habit_ratio, nightmare_todo_ratio: stat.nightmare_todo_ratio, nomral_habit_ratio: stat.nomral_habit_ratio, normal_todo_ratio: stat.normal_todo_ratio, spent_per_day: stat.spent_per_day, user_id: stat.user_id, vhard_habit_ratio: stat.vhard_habit_ratio, vhard_todo_ratio: stat.vhard_todo_ratio, weekly_budget_ratio: stat.weekly_budget_ratio, worst_habit_string: stat.worst_habit_string, worst_todo: stat.worst_todo }
    assert_redirected_to stat_path(assigns(:stat))
  end

  def test_destroy
    assert_difference("Stat.count", -1) do
      delete :destroy, id: stat
    end

    assert_redirected_to stats_path
  end
end
