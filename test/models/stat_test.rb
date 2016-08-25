require "test_helper"

class StatTest < ActiveSupport::TestCase
  def stat
    @stat ||= Stat.new
  end

  def test_valid
    assert stat.valid?
  end
end
