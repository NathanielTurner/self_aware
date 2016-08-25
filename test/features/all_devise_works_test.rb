require "test_helper"

class AllDeviseWorksTest < Capybara::Rails::TestCase
  setup do
    @user = set_user
  end

  test "devise works" do
    visit root_path
    click_link('Sign in')
    assert_content page, 'Forgot password?'
    fill_in('Email', with: @user.email)
    fill_in('Password', with: 'password')
    click_button('Sign in')
    assert_content page, 'Signed in successfully'
    click_link('Sign out')
  end
end
