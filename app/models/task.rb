class Task < ActiveRecord::Base
  belongs_to :user
  has_many :submits, dependent: :delete_all
  accepts_nested_attributes_for :submits, allow_destroy: true
  validates :title, presence: true
end
