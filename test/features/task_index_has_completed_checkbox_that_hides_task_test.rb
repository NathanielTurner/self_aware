require "test_helper"

class TaskIndexHasCompletedCheckboxThatHidesTaskTest < Capybara::Rails::TestCase

  Capybara.javascript_driver = :webkit
  before(:all) do
    Capybara.current_driver = :webkit
  end
  after(:all) do
    Capybara.use_default_driver
  end

  test "users can click checkbox on indexed task and have it hide" do
    visit new_user_registration_path
    fill_in('Name', with: 'Test')
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'password')
    fill_in('Password confirmation', with: 'password')
    click_button('Sign up')
    visit tasks_new_path
    fill_in('Title', with: 'Test Title')
    fill_in('Description', with: 'Test Description')
    click_button('Create Task')
    visit tasks_path
    assert_equal 2, all('tr').count
    within_row('Test Title') do
      find('label').click
    end
    assert_equal 1, all('tr').count
  end

end
