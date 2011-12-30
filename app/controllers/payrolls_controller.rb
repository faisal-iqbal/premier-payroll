class PayrollsController < ActionController::Base
  layout 'application'
  before_filter :set_tab

  def index
    @payrolls = Payroll.all
  end

  def new
    @start = params[:start] ? Time.parse(params[:start]) : Payroll.last.end+1
    @end = params[:end] ? Time.parse(params[:end]) : Time.now.beginning_of_day

    @payroll = Payroll.new()
    @payroll.generate(@start, @end, get_working_days(@start.to_date, @end.to_date))
    render :show
  end

  def show
    @payroll = Payroll.find(params[:id])
  end


  def destroy
    @payroll = Payroll.find(params[:id])

    respond_to do |format|
      if @payroll.destroy
        flash[:notice] = 'Payroll was successfully deleted.'
        format.html { redirect_to payrolls_path }
        format.xml  { head :ok }
        format.js { render :partial => "shared/update" }
      else
        flash[:error] = @payroll.errors
        format.html { redirect_to payrolls_path }
        format.xml  { render :xml => @payroll.errors, :status => :unprocessable_entity }
        format.js {
          messages = @payroll.errors.collect { | error | error.join(' '); }
          message = messages.join(' <br /> ')
          render :json => message, :status => 444
        }
      end
    end
  end

  private

  def get_working_days(d1, d2)
    diff = d2 - d1
    diff - holidays(d1, d2)
  end

  def holidays(d1, d2)
    holidays = 0
    wdays = [0,6]
    ret = (d2-d1).divmod(7)
    holidays =  ret[0].truncate * wdays.length
    d1 = d2 - ret[1]
    while(d1 <= d2)
      if wdays.include?(d1.wday)
        holidays += 1
      end
      d1 += 1
    end
    holidays
  end

  def set_tab
    @nav_tab = 'payrolls'
  end
end