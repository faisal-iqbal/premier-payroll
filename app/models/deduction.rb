class Deduction < ActiveRecord::Base
  belongs_to :employee

  validates :date, :presence => true
  validates :employee, :presence => true
  validates :amount, :presence => true, :numericality => true
end