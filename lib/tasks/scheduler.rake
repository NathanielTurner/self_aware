require 'modules/data_maintainer'
require 'modules/stat_generator'
include DataMaintainer
include StatGenerator
require 'modules/time_wizard'
include TimeWizard


desc "determin habits to be shown today"
task daily_evauluation: :environment do
	daily_habit_maintenance
	daily_to_do_maintenace
	daily_budget_maintenance
	evaluate_limit
	user = User.all
	user.each do |u|
	  calculate_stats(u)
	end
end
