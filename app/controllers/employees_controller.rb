class EmployeesController < ActionController::Base
  before_filter :authenticate_user!
  before_filter :set_tab
  layout 'application'

  def index
    @employees = Employee.all
  end

  def new
    @employee = Employee.new

    respond_to do |format|
      format.html { render :action => "edit" }
      format.xml  { render :xml => @employee }
    end
  end

  def create
    @employee = Employee.new(params[:employee])

    respond_to do |format|
      if @employee.save
        flash[:notice] = 'Employee was successfully created.'
        format.html { redirect_to employees_path }
        format.xml  { head :ok }
        format.js { render :partial => "shared/update" }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @employee.errors, :status => :unprocessable_entity }
        format.js {
          messages = @employee.errors.collect { | error | error.join(' '); }
          message = messages.join(' <br /> ')
          render :json => message, :status => 444
        }
      end
    end
  end

  def edit
    @employee = Employee.find(params[:id])

    respond_to do |format|
      format.html
      format.xml  { render :xml => @employee }
    end
  end

  def update
    @employee = Employee.find(params[:id])

    respond_to do |format|
      if @employee.update_attributes(params[:employee])
        flash[:notice] = 'Employee was successfully updated.'
        format.html { redirect_to employees_path }
        format.xml  { head :ok }
        format.js { render :partial => "shared/update" }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @employee.errors, :status => :unprocessable_entity }
        format.js {
          messages = @employee.errors.collect { | error | error.join(' '); }
          message = messages.join(' <br /> ')
          render :json => message, :status => 444
        }
      end
    end
  end

  def destroy
    @employee = Employee.find(params[:id])

    respond_to do |format|
      if @employee.destroy
        flash[:notice] = 'Employee was successfully deleted.'
        format.html { redirect_to employees_path }
        format.xml  { head :ok }
        format.js { render :partial => "shared/update" }
      else
        flash[:error] = @employee.errors
        format.html { redirect_to employees_path }
        format.xml  { render :xml => @employee.errors, :status => :unprocessable_entity }
        format.js {
          messages = @employee.errors.collect { | error | error.join(' '); }
          message = messages.join(' <br /> ')
          render :json => message, :status => 444
        }
      end
    end
  end

  private
  def set_tab
    @nav_tab = 'employees'
  end
end