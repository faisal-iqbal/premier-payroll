class Employee < ActiveRecord::Base
  belongs_to :department
  belongs_to :shift
  
  has_many :allowances
  has_many :deductions
  has_many :attendances
  
  def full_name
    "#{self.first_name} #{self.last_name}"
  end
  
  def working_days_between(start_date, end_date)
    self.attendances.where("date > '#{start_date}' AND date < '#{end_date}' AND status NOT IN ('On Leave', '' )")
  end
  
  def leave_days(start_date, end_date)
    self.attendances.where( "date > '#{start_date}' AND date < '#{end_date}' AND status IN ('On Leave', '' )")
  end
  
  def half_days(start_date, end_date)
    self.attendances.where("date > '#{start_date}' AND date < '#{end_date}' AND status IN ('Half Day' )")
  end
  
  def early_out_days(start_date, end_date)
    self.attendances.where("date > '#{start_date}' AND date < '#{end_date}' AND status IN ('Early Out' )")
  end
  
  def late_in_days(start_date, end_date)
    self.attendances.where("date > '#{start_date}' AND date < '#{end_date}' AND status IN ('Late In' )")
  end
  
  def total_allowances(start_date, end_date)
    total = 0
    all_allowances = self.allowances.where("date > '#{start_date}' AND date < '#{end_date}'")
    all_allowances.each{|a| total+= a.amount}
    total
  end
  
  def total_deductions(start_date, end_date)
    total = 0
    all_deductions = self.deductions.where("date > '#{start_date}' AND date < '#{end_date}'")
    all_deductions.each{|d| total+= d.amount}
    total
  end
  
  def taxable_salary(start_date, end_date)
    self.salary + total_allowances(start_date, end_date) - self.medical - total_deductions(start_date, end_date)
  end
  
  def basic_salary
    self.salary - self.medical - self.utilities
  end
  
  def tax(amount)
    amount*0.1
  end
  
  def generate_payslip(start_date, end_date)
    taxable_salary = taxable_salary(start_date, end_date)
    
    payslip = Payslip.new(:employee_id => self.id,
                      :leave_days => leave_days(start_date, end_date),
                      :half_days => half_days(start_date, end_date),
                      :late_in_days => late_in_days(start_date, end_date),
                      :early_out_days => early_out_days(start_date, end_date),
                      :total_allowances => total_allowances(start_date, end_date),
                      :total_deductions => total_deductions(start_date, end_date),
                      :salary => salary,
                      :tax => tax(taxable_salary),
                      :salary_payout => taxable_salary(start_date, end_date) - tax(taxable_salary))

    payslip
  end
end