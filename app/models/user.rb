class User < ActiveRecord::Base
  has_many :tasks, dependent: :delete_all
  has_many :budgets, dependent: :delete_all
  has_many :withdrawals, dependent: :delete_all
  has_many :submits, dependent: :delete_all
  has_one :stat, dependent: :destroy
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, if: :new_record?
  after_create :set_stat_table

  def set_default_role
    self.role ||= :user
  end
  def set_stat_table
    Stat.create(user_id: self.id)
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :confirmable, :lockable, :timeoutable ,:recoverable,
         :rememberable, :trackable, :validatable, :omniauthable
end
