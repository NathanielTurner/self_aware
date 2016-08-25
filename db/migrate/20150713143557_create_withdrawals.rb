class CreateWithdrawals < ActiveRecord::Migration
  def change
    create_table :withdrawals do |t|
      t.integer :user_id
      t.integer :budget_id
      t.decimal :amount
      t.boolean :processed,     default: false
      t.boolean :repeat
      t.integer :repeat_every,  default: 1
      t.boolean :day,           default: false
      t.boolean :week,          default: false
      t.boolean :month,         default: false
      t.boolean :year,          default: false

      t.timestamps null: false
    end
  end
end
