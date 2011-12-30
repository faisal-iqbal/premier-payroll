class Payslip < ActiveRecord::Base
  belongs_to :payroll
  belongs_to :employee
end