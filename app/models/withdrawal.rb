class Withdrawal < ActiveRecord::Base
  belongs_to :budget
  belongs_to :user
  validates :amount, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }
end
