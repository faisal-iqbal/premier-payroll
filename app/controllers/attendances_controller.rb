class AttendancesController < ActionController::Base
  before_filter :authenticate_user!
  before_filter :set_tab
  layout 'application'
  
  def index
    @employees = Employee.all
    @attendances = {}
    if params[:date]
      @date = Time.parse(params[:date])
    else
      @date = Time.now.beginning_of_day
    end
    @employees.each do |emp|
      @attendances[emp.id] = Attendance.find_by_date_and_employee_id(@date, emp.id) || Attendance.new(:date=>@date, :timestamp=>@date)
    end
  end
  
  def save_attendance
    @failed_records = []
    @successfull = @failed = 0
    params[:attendances].each do |emp_id, attendance|
      unless attendance['status'].blank? or attendance.delete('updated') == '0'
        if tmp = Attendance.find_by_date_and_employee_id(attendance['date'], attendance['employee_id'])
          if tmp.update_attributes(attendance)
            @successfull += 1
          else
            @failed += 1
            @failed_records << attendance[:employee_id]
          end
        else
          tmp = Attendance.new(attendance)
          if tmp.save
            @successfull += 1
          else
            @failed += 1
            @failed_records << attendance[:employee_id]
          end
        end
      end
    end
    flash[:notice] = "#{@successfull} record(s) saved" if @successfull
    flash[:error] = "failed to save #{@failed} record(s)" if @failed and @failed > 0 
    redirect_to :back 
  end

  private
  def set_tab
    @nav_tab = 'attendance'
  end
end