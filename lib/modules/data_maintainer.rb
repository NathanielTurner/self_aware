require 'modules/time_wizard'
include TimeWizard

module DataMaintainer

  def daily_habit_maintenance
    habits = Task.where(style: 'habit')
    habits.each do |habit|
      if habit.submitted == true
        habit.consecutive_submits += 1
        habit.save
      elsif habit.submitted == false
        Submit.create(task_id: habit.id, on_time: false)
        habit.consecutive_submits = (0.7 * habit.consecutive_submits).round
        habit.save
      end
      set_performance(habit)
    end
    habits.update_all home_page: false
    habits.update_all submitted: false
    habits_today = habits.where(current_day_name.to_sym => true)
    habits_today.update_all home_page: true
  end

  def set_performance(habit)
    level = habit.consecutive_submits
    case level
    when  0, 1
      habit.update performance: 'poor'
    when 2, 3
      habit.update performance: 'low'
    when 4, 5, 6
      habit.update performance: 'adaquate'
    when 7, 8
      habit.update performance: 'high'
    when 9, 10
      habit.update performance: 'fantastic'
    when level > 10
      habit.update performance: 'phenominal'
    end
  end

  def daily_to_do_maintenace
    to_dos = Task.where(style: 'to_do')
    to_dos.each do |to_do|
      check_over_due(to_do)
    end
    easy = to_dos.where(difficulty: 0, home_page: false)
    normal = to_dos.where(difficulty: 1, home_page: false)
    hard = to_dos.where(difficulty: 2, home_page: false)
    very_hard = to_dos.where(difficulty: 3, home_page: false)
    easy.each do |e|
      to_do_checker(e, 2)
    end
    normal.each do |e|
      to_do_checker(e, 4)
    end
    hard.each do |e|
      to_do_checker(e, 7)
    end
    very_hard.each do |e|
      to_do_checker(e, 12)
    end
  end

  def check_over_due(to_do)
    to_do.update over_due: false
    if Time.zone.now > to_do.due_date + 1.day
      to_do.update over_due: true
    end
  end

  def to_do_checker(to_do, num)
    if Time.zone.now + num.days > to_do.due_date
      to_do.update home_page: true
    end
  end

  def evaluate_limit
    if new_week?
      weekly_budgets = Budget.where(weekly_limit: true)
      weekly_budgets.each do |budget|
        if budget.amount > budget.initial_amount
          budget.weekly_failures += 1
        else
          budget.weekly_passes += 1
        end
        budget.update amount: 0.0

      end
    end
    if new_month?
      monthly_budgets = Budget.where(monthly_limit: true)
      monthly_budgets.each do |budget|
        if budget.amount > budget.initial_amount
          budget.monthly_failures += 1
        else
          budget.monthly_passes += 1
        end
        budget.update amount: 0.0
      end
    end
  end

  def set_default_reset_time(budget)
    if budget.weekly_limit == true
      if current_day_name == 'sunday'
        budget.update time_till_reset: 'Resets tomorrow at 12:30am'
      else
        budget.update time_till_reset: "Resets in #{days_till_new_week} days"
      end
    else
      if (((Time.zone.now).end_of_month + 1.day) -
            (Time.zone.now)).to_i/(24*60*60) == 1
        budget.update time_till_reset: 'Resets tomorrow at 12:30am'
      else
        budget.update time_till_reset: "Resets in #{days_till_new_month} days"
      end
    end
  end

  def daily_budget_maintenance

    weekly_budgets = Budget.where(weekly_limit: true)
    monthly_budgets = Budget.where(monthly_limit: true)

    if current_day_name == 'sunday'
      weekly_budgets.update_all time_till_reset: 'Resets tomorrow at 12:30am'
    else
      weekly_budgets.update_all time_till_reset:
          "Resets in #{days_till_new_week} days"
    end

    if (((Time.zone.now).end_of_month + 1.day) -
          (Time.zone.now)).to_i/(24*60*60) == 1
      monthly_budgets.update_all time_till_reset: 'Resets tomorrow at 12:30am'
    else
      monthly_budgets.update_all time_till_reset:
          "Resets in #{days_till_new_month} days"
    end

  end

  def update_balance(budget)
      unprocessed = budget.withdrawals.where(processed: false)
      budget.amount += unprocessed.sum(:amount)
      budget.percent_complete =
          ((budget.amount / budget.initial_amount) * 100).to_i
      budget.save
      unprocessed.update_all processed: true
      if budget.weekly_limit == true && budget.amount > 0
        weekly_ratio = (budget.amount / get_days_for_week) * 7
        weekly_limit = budget.initial_amount
        if weekly_ratio > weekly_limit
          budget.update status: 'At Risk'
        elsif weekly_ratio / weekly_limit > 0.85
          budget.update status: 'Close But Safe'
        elsif weekly_ratio / weekly_limit > 0.5
          budget.update status: 'Stable'
        elsif weekly_ratio / weekly_limit < 0.5
          budget.update status: 'Below by Half'
        end
      else
        monthly_ratio = (budget.amount / get_days_for_month) * get_days_in_month
        monthly_limit = budget.initial_amount
        if monthly_ratio > monthly_limit
          budget.update status: 'At Risk'
        elsif monthly_ratio / monthly_limit > 0.85
          budget.update status: 'Close But Safe'
        elsif monthly_ratio / monthly_limit > 0.5
          budget.update status: 'Stable'
        elsif monthly_ratio / monthly_limit < 0.5
          budget.update status: 'Below by Half'
        end
      end
  end

  def remove_withdrawal(budget, amount)
    budget.amount -= amount
    budget.percent_complete =
        ((budget.amount / budget.initial_amount) * 100).to_i
    budget.save

    if budget.weekly_limit == true && budget.amount > 0
      weekly_ratio = (budget.amount / get_days_for_week) * 7
      weekly_limit = budget.initial_amount
      if weekly_ratio > weekly_limit
        budget.update status: 'At Risk'
      elsif weekly_ratio / weekly_limit > 0.85
        budget.update status: 'Close But Safe'
      elsif weekly_ratio / weekly_limit > 0.5
        budget.update status: 'Stable'
      elsif weekly_ratio / weekly_limit < 0.5
        budget.update status: 'Below by Half'
      end
    else
      monthly_ratio = (budget.amount / get_days_for_month) * get_days_in_month
      monthly_limit = budget.initial_amount
      if monthly_ratio > monthly_limit
        budget.update status: 'At Risk'
      elsif monthly_ratio / monthly_limit > 0.85
        budget.update status: 'Close But Safe'
      elsif monthly_ratio / monthly_limit > 0.5
        budget.update status: 'Stable'
      elsif monthly_ratio / monthly_limit < 0.5
        budget.update status: 'Below by Half'
      end
    end
  end

  def get_days_for_week
     (((Time.zone.now + 1.day) - Time.zone.now.beginning_of_week ).to_i / (24*60*60)).abs
  end

  def get_days_for_month
     (((Time.zone.now + 1.day) - Time.zone.now.beginning_of_month ).to_i / (24*60*60)).abs
  end

  def get_days_in_month
    ((Time.zone.now.beginning_of_month - Time.zone.now.end_of_month).to_i / (24*60*60)).abs
  end

end
