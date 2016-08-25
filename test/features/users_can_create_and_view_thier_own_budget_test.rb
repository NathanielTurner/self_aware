#require "test_helper"
#
#class UsersCanCreateAndViewThierOwnBudgetTest < Capybara::Rails::TestCase
#  setup do
#    @user_one = set_user
#    @user_two = set_user
#  end
#
#  test "users not logged in should not acces budget pages" do
#    visit budgets_new_path
#    assert_content page, 'You need to sign in or sign up before continuing'
#    visit budgets_path
#    assert_content page, 'You need to sign in or sign up before continuing'
#  end
#
#  test "logged in users can create budgets and view only theirs" do
#    visit root_path
#    click_link('Sign in')
#    fill_in('Email', with: @user_one.email)
#    fill_in('Password', with: 'password')
#    click_button('Sign in')
#    assert_content page, 'Signed in successfully.'
#    visit budgets_new_path
#    fill_in('Amount', with: '30000.05')
#    click_button('Create Budget')
#    assert_content page, 'Budget was successfully created.'
#    visit budgets_path
#    assert_content page, '30000.05'
#    click_link('Sign out')
#    assert_content page, 'Signed out successfully.'
#    click_link('Sign in')
#    fill_in('Email', with: @user_two.email)
#    fill_in('Password', with: 'password')
#    click_button('Sign in')
#    assert_content page, 'Signed in successfully.'
#    visit budgets_path
#    refute_content page, '30000.05'
#    click_link('Sign out')
#    assert_content page, 'Signed out successfully.'
#  end
#end
