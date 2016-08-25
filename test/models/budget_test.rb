require "test_helper"

class BudgetTest < ActiveSupport::TestCase
  def budget
    @budget ||= Budget.new
  end

  def test_valid
    assert budget.valid?
  end
end
