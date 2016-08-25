# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150722084628) do

  create_table "budgets", force: :cascade do |t|
    t.decimal  "amount",           default: 0.0
    t.decimal  "initial_amount"
    t.string   "name"
    t.string   "time_till_reset"
    t.string   "status"
    t.integer  "percent_complete", default: 0
    t.boolean  "weekly_limit",     default: true
    t.boolean  "monthly_limit",    default: false
    t.integer  "weekly_passes",    default: 0
    t.integer  "weekly_failures",  default: 0
    t.integer  "monthly_passes",   default: 0
    t.integer  "monthly_failures", default: 0
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "user_id"
  end

  add_index "budgets", ["user_id"], name: "index_budgets_on_user_id"

  create_table "stats", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "nightmare_habit_ratio",  default: 0
    t.integer  "vhard_habit_ratio",      default: 0
    t.integer  "hard_habit_ratio",       default: 0
    t.integer  "nomral_habit_ratio",     default: 0
    t.integer  "easy_habit_ratio",       default: 0
    t.integer  "nightmare_todo_ratio",   default: 0
    t.integer  "vhard_todo_ratio",       default: 0
    t.integer  "hard_todo_ratio",        default: 0
    t.integer  "normal_todo_ratio",      default: 0
    t.integer  "easy_todo_ratio",        default: 0
    t.integer  "monthly_budget_ratio",   default: 0
    t.integer  "weekly_budget_ratio",    default: 0
    t.decimal  "spent_per_day",          default: 0.0
    t.float    "most_spent",             default: 0.0
    t.string   "best_habit"
    t.string   "worst_habit"
    t.string   "best_to_do_difficulty"
    t.string   "worst_to_do_difficulty"
    t.string   "best_habit_difficulty"
    t.string   "worst_habit_difficulty"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "submits", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "task_id"
    t.boolean  "on_time"
    t.string   "week_day"
    t.boolean  "on_repeat"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "submits", ["task_id"], name: "index_submits_on_task_id"

  create_table "tasks", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.datetime "due_date"
    t.string   "assigned_by"
    t.integer  "risk",                default: 0
    t.integer  "difficulty",          default: 0
    t.string   "reminder_type"
    t.datetime "remind_at"
    t.boolean  "sunday"
    t.boolean  "monday"
    t.boolean  "tuesday"
    t.boolean  "wednesday"
    t.boolean  "thursday"
    t.boolean  "friday"
    t.boolean  "saturday"
    t.string   "style"
    t.boolean  "home_page",           default: false
    t.boolean  "completed",           default: false
    t.datetime "completed_on"
    t.boolean  "submitted",           default: false
    t.integer  "submit_count",        default: 0
    t.integer  "consecutive_submits", default: 5
    t.integer  "consecutive_record",  default: 0
    t.string   "performance",         default: "adaquate"
    t.boolean  "over_due",            default: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "tasks", ["style"], name: "index_tasks_on_style"
  add_index "tasks", ["user_id"], name: "index_tasks_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "role"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
    t.string   "provider"
    t.string   "uid"
    t.integer  "failed_attempts"
    t.string   "unlock_token"
    t.datetime "locked_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count"
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "withdrawals", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "budget_id"
    t.decimal  "amount"
    t.boolean  "processed",    default: false
    t.boolean  "repeat"
    t.integer  "repeat_every", default: 1
    t.boolean  "day",          default: false
    t.boolean  "week",         default: false
    t.boolean  "month",        default: false
    t.boolean  "year",         default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

end
