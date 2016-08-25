require "test_helper"

class BudgetsControllerTest < ActionController::TestCase
  def setup
    @user = set_user
    sign_in :user, @user
  end

  def budget
    @budget ||= budgets :one
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:budgets)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference("Budget.count") do
      post :create, budget: { amount: budget.amount }
    end

    assert_redirected_to budget_path(assigns(:budget))
  end

  def test_show
    get :show, id: budget
    assert_response :success
  end

  def test_edit
    get :edit, id: budget
    assert_response :success
  end

  def test_update
    put :update, id: budget, budget: { amount: budget.amount }
    assert_redirected_to budget_path(assigns(:budget))
  end

  def test_destroy
    assert_difference("Budget.count", -1) do
      delete :destroy, id: budget
    end

    assert_redirected_to budgets_path
  end
end
