class Department < ActiveRecord::Base
  belongs_to :zone
  has_many   :employees

  def self.option_for_select
    options = []
    Department.all.group_by(&:zone_id).each do |zone_id, departments|
      options << ["#{departments.first.zone.name}, #{departments.first.zone.region.name}",
        departments.collect{|d|[d.name,d.id]}]
    end
    options
  end
end