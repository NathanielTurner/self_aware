class Budget < ActiveRecord::Base
  belongs_to :user
  validates :initial_amount, presence: true
  has_many :withdrawals, dependent: :delete_all
end
