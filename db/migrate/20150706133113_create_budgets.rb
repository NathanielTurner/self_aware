class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.decimal  :amount,            default: 0.00
      t.decimal  :initial_amount
      t.string   :name
      t.string   :time_till_reset
      t.string   :status
      t.integer  :percent_complete,  default: 0.0
      t.boolean  :weekly_limit,      default: true
      t.boolean  :monthly_limit,     default: false
      t.integer  :weekly_passes,     default: 0
      t.integer  :weekly_failures,   default: 0
      t.integer  :monthly_passes,    default: 0
      t.integer  :monthly_failures,  default: 0

      t.timestamps null: false
    end
  end
end
