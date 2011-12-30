class SetupDb < ActiveRecord::Migration
  def self.up
    create_table :regions do |t|
      t.string	:name
    end
    create_table :zones do |t|
      t.string	:name
      t.integer	:region_id
    end
    create_table :departments do |t|
      t.string	:name
      t.integer	:zone_id
    end
    create_table :shifts do |t|
      t.string		:name
      t.decimal		:overtime
      t.datetime	:start
      t.datetime	:end
      t.integer		:comments
    end
    create_table :employees do |t|
      t.string		:first_name
      t.string		:last_name
      t.integer		:age
      t.boolean		:married
      t.decimal		:medical
      t.decimal		:utilities
      t.decimal		:salary
      t.integer		:shift_id
      t.integer		:department_id
      t.datetime	:joining_date
      t.text		  :comments
    end
    create_table :roles do |t|
      t.string	:name
    end
    create_table :employees_roles do |t|
      t.integer	:employee_id
      t.integer	:role
    end
    create_table :department_reporters do |t|
      t.integer	:department_id
      t.integer	:employee_id
    end
    create_table :attendances do |t|
      t.integer		:employee_id
      t.date      :date
      t.datetime  :timestamp
      t.string		:status
    end
    create_table :allowances do |t|
      t.integer		:employee_id
      t.decimal		:amount
      t.datetime	:date
      t.text		  :comments
    end
    create_table :deductions do |t|
      t.integer		:employee_id
      t.decimal		:amount
      t.datetime	:date
      t.text		  :comments
    end
    create_table :tax_ranges do |t|
      t.decimal	:from
      t.decimal	:to
      t.decimal	:taxable
      t.text	  :comments
    end
  end
  
  def self.down
    drop_table :tax_ranges
    drop_table :deductions
    drop_table :allowances
    drop_table :attendances
    drop_table :department_reporters
    drop_table :employees_roles
    drop_table :roles
    drop_table :employees
    drop_table :shifts
    drop_table :departments
    drop_table :zones
    drop_table :regions
  end
end