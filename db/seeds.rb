require 'modules/feature_helper'
include FeatureHelper
#user = CreateAdminService.new.call
#puts 'CREATED ADMIN USER: ' << user.email
#puts_interval = 1000
#puts "created #{i+1} tasks" if (i+1) % puts_interval == 0

programmer = User.new(
	name: 'Nathaniel Turner',
	email: 'nateturner1990@gmail.com',
	password: 'password',
	password_confirmation: 'password'
)
programmer.skip_confirmation!
programmer.save

set_tasks(50, programmer.id)

weekly = Budget.create(name: 'Test Budget Weekly', weekly_limit: true, initial_amount: 2000,
								user_id: programmer.id)

monthly = Budget.create(name: 'Test Budget Monthly', monthly_limit: true, initial_amount: 8000,
												user_id: programmer.id)

20.times do
	Withdrawal.create(user_id: programmer.id, budget_id: weekly.id, amount: Faker::Commerce.price,
											created_at: Faker::Time.between(1.months.ago, Time.now, :all))
end

20.times do
	Withdrawal.create(user_id: programmer.id, budget_id: monthly.id, amount: Faker::Commerce.price,
											created_at: Faker::Time.between(2.months.ago, Time.now, :all))
end
