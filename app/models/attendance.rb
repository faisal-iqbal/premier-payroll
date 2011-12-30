class Attendance < ActiveRecord::Base
  belongs_to :employee

  STATUS_MESSAGES = { :present => "Present",
    :late => "Late In",
    :late => "Early Out",
    :half => "Half Day",
    :leave => "On Leave",
    :paid_leave => "On Paid Leave" }
  
  def payable?
    !(["On Leave", ""].include?(self.status))
  end
end