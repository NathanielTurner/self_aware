require "test_helper"

class DepositTest < ActiveSupport::TestCase
  def deposit
    @deposit ||= Deposit.new
  end

  def test_valid
    assert deposit.valid?
  end
end
