require "test_helper"

class WithdrawalTest < ActiveSupport::TestCase
  def withdrawal
    @withdrawal ||= Withdrawal.new
  end

  def test_valid
    assert withdrawal.valid?
  end
end
