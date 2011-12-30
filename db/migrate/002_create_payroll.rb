class CreatePayroll < ActiveRecord::Migration
  def self.up    
    create_table :payrolls do |t|
      t.datetime	:start
      t.datetime	:end
      t.decimal   :total_payout
      t.integer   :working_days
      t.text      :comments
    end
    create_table :payslips do |t|
      t.integer :employee_id
      t.integer :payroll_id
      t.integer :leave_days
      t.integer :half_days
      t.integer :late_in_days
      t.integer :early_out_days
      t.decimal	:salary
      t.decimal	:total_allowances
      t.decimal	:total_deductions
      t.decimal	:tax
      t.decimal	:salary_payout
      t.text	  :comments
    end
  end
  
  def self.down
    drop_table :payslips
    drop_table :payrolls
  end
end