class Payroll < ActiveRecord::Base
  has_many :payslips
  
  def generate(start_date, end_date, work_days)
    self.payslips.clear
    self.start = start_date
    self.end = end_date
    self.working_days = work_days
    self.total_payout = 0
    Employee.all.each do |emp|
      ps =  emp.generate_payslip(start_date, end_date)
      self.payslips << ps
      self.total_payout += ps.salary_payout
    end
    save
  end
end