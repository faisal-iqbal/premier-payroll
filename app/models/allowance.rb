class Allowance < ActiveRecord::Base
  belongs_to :employee

  validates :date, :presence => true
  validates :employee_id, :presence => true
  validates :amount, :presence => true, :numericality => true
end