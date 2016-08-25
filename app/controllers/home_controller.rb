
class HomeController < ApplicationController
  def home
    unless current_user == nil
      @visitor = false
      @to_dos = current_user.tasks.where(style: 'to_do',
                                         completed: false,
                                         home_page: true).order('over_due DESC, due_date ASC')
      @habits = current_user.tasks.where(style: 'habit',
                                         submitted: false,
                                         home_page: true).order(consecutive_submits: :desc)
      @over_dues = @to_dos.where(over_due: true)
      @poor_habits = @habits.where(performance: 'poor')
      @budgets = current_user.budgets
      @at_risks = @budgets.where(status: 'At Risk')
    else
      @visitor = true
    end
  end

  def show
  end
end
