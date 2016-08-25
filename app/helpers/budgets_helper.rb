module BudgetsHelper

	def reset_type(budget)
		if budget.weekly_limit == true
			return 'Weekly'
		else
			return 'Monthly'
		end
	end

	def num_not_over_drawn(budgets)
		count = 0
		budgets.each do |budget|
		  count += budget.weekly_passes
			count += budget.monthly_passes
		end
		return count
	end

	def num_over_drawn(budgets)
		count = 0
		budgets.each do |budget|
		  count += budget.weekly_failures
			count += budget.monthly_failures
		end
		return count;
	end

	def average_spent_daily(withdrawals)
		first = withdrawals.first.created_at
		last = withdrawals.last.created_at
	  days = ((first - last).to_i / (24*60*60)).abs
		if days == 0
			return (withdrawals.sum(:amount) / withdrawals.count).to_f.round(2)
		else
			return	(withdrawals.sum(:amount) / days).to_f.round(2)
		end
	end

end
