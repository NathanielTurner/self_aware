require "test_helper"

class SubmitTest < ActiveSupport::TestCase
  def submit
    @submit ||= Submit.new
  end

  def test_valid
    assert submit.valid?
  end
end
