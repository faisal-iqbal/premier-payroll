class PayslipsController < ActionController::Base
  before_filter :authenticate_user!
  before_filter :set_tab
  layout 'application'

  def index
    @payslips = Payslip.all.group_by(&:payroll_id)
  end

  def show
    @payslip = Payslip.find(params[:id])
  end

  def destroy
    @payslip = Payslip.find(params[:id])

    respond_to do |format|
      if @payslip.destroy
        flash[:notice] = 'Payslip was successfully deleted.'
        format.html { redirect_to payslips_path }
        format.xml  { head :ok }
        format.js { render :partial => "shared/update" }
      else
        flash[:error] = @payslip.errors
        format.html { redirect_to payslips_path }
        format.xml  { render :xml => @payslip.errors, :status => :unprocessable_entity }
        format.js {
          messages = @payslip.errors.collect { | error | error.join(' '); }
          message = messages.join(' <br /> ')
          render :json => message, :status => 444
        }
      end
    end
  end

  private

  def set_tab
    @nav_tab = 'payslips'
  end
end