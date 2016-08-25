require "test_helper"

class TasksControllerTest < ActionController::TestCase
  def setup
    @user = set_user
    @tasks = set_tasks(1, @user.id)
    sign_in :user, @user
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:tasks)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference("Task.count") do
      post :create, task: {completed: false, description: "this is a description",
          title: "My super task", user_id: session[:user_id] }
    end

    assert_redirected_to tasks_path
  end

  def test_show
    get :show, id: @tasks[0].id
    assert_response :success
  end

  def test_edit
    get :edit, id: @tasks[0].id
    assert_response :success
  end

  def test_update
    put :update, id: @tasks[0].id, task: {completed: false, description: "this is not a description",
        title: "not my super task", user_id: session[:user_id] }
    assert_redirected_to task_path(assigns(:task))
  end

  def test_destroy
    assert_difference("Task.count", -1) do
      delete :destroy, id: @tasks[0].id
    end

    assert_redirected_to tasks_path
  end
end
