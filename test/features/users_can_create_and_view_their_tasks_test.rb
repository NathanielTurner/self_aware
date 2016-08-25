require "test_helper"

class UsersCanCreateAndViewTheirTasksTest < Capybara::Rails::TestCase
  setup do
    @user_one = set_user
    @user_two = set_user
  end

  test "Users cannot access tasks unless logged in" do
    visit tasks_path
    assert_content page, "You need to sign in or sign up before continuing."
    visit tasks_new_path
    assert_content page, "You need to sign in or sign up before continuing."
  end

  test "logged in users can create tasks" do
    visit root_path
    click_link('Sign in')
    fill_in('Email', with: @user_one.email)
    fill_in('Password', with: 'password')
    click_button('Sign in')
    assert_content page, 'Signed in successfully.'
    visit tasks_new_path
    fill_in('Title', with: 'user ones task')
    fill_in('Description', with: 'This should not show up on user twos list')
    click_button('Create Task')
    assert_content page, 'Task was successfully created.'
    visit tasks_path
    assert_content page, 'This should not show up on user twos list'
    click_link('Sign out')
    assert_content page, 'Signed out successfully.'
    click_link('Sign in')
    fill_in('Email', with: @user_two.email)
    fill_in('Password', with: 'password')
    click_button('Sign in')
    assert_content page, 'Signed in successfully.'
    visit tasks_path
    refute_content page, 'This should not show up on user twos list'
    click_link('Sign out')
  end

end
