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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120102092146) do

  create_table "allowances", :force => true do |t|
    t.integer  "employee_id"
    t.decimal  "amount"
    t.datetime "date"
    t.text     "comments"
  end

  create_table "attendances", :force => true do |t|
    t.integer  "employee_id"
    t.datetime "date"
    t.datetime "timestamp"
    t.string   "status"
  end

  create_table "deductions", :force => true do |t|
    t.integer  "employee_id"
    t.decimal  "amount"
    t.datetime "date"
    t.text     "comments"
  end

  create_table "department_reporters", :force => true do |t|
    t.integer "department_id"
    t.integer "employee_id"
  end

  create_table "departments", :force => true do |t|
    t.string  "name"
    t.integer "zone_id"
  end

  create_table "employees", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "age"
    t.boolean  "married"
    t.decimal  "medical"
    t.decimal  "utilities"
    t.decimal  "salary"
    t.integer  "shift_id"
    t.integer  "department_id"
    t.datetime "joining_date"
    t.text     "comments"
  end

  create_table "employees_roles", :force => true do |t|
    t.integer "employee_id"
    t.integer "role"
  end

  create_table "payrolls", :force => true do |t|
    t.datetime "start"
    t.datetime "end"
    t.decimal  "total_payout"
    t.integer  "working_days"
    t.text     "comments"
  end

  create_table "payslips", :force => true do |t|
    t.integer "employee_id"
    t.integer "payroll_id"
    t.integer "leave_days"
    t.integer "half_days"
    t.integer "late_in_days"
    t.integer "early_out_days"
    t.decimal "salary"
    t.decimal "total_allowances"
    t.decimal "total_deductions"
    t.decimal "tax"
    t.decimal "salary_payout"
    t.text    "comments"
  end

  create_table "regions", :force => true do |t|
    t.string "name"
  end

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  create_table "shifts", :force => true do |t|
    t.string   "name"
    t.decimal  "overtime"
    t.datetime "start"
    t.datetime "end"
    t.integer  "comments"
  end

  create_table "tax_ranges", :force => true do |t|
    t.decimal "from"
    t.decimal "to"
    t.decimal "taxable"
    t.text    "comments"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "",    :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                                 :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "zones", :force => true do |t|
    t.string  "name"
    t.integer "region_id"
  end

end
