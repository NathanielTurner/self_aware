class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.string :title
      t.text :description
      t.datetime :due_date
      t.string :assigned_by
      t.integer :risk,                     default: 0
      t.integer :difficulty,               default: 0
      t.string :reminder_type
      t.datetime :remind_at
      t.boolean :sunday
      t.boolean :monday
      t.boolean :tuesday
      t.boolean :wednesday
      t.boolean :thursday
      t.boolean :friday
      t.boolean :saturday
      t.string :style
      t.boolean :home_page,                default: false
      t.boolean :completed,                default: false
      t.datetime :completed_on
      t.boolean :submitted,                default: false
      t.integer :submit_count,             default: 0
      t.integer :consecutive_submits,      default: 5
      t.integer :consecutive_record,       default: 0
      t.string :performance,               default: "adaquate"
      t.boolean :over_due,                 default: false

      t.timestamps null: false
    end
  end
end
