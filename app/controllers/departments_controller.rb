class DepartmentsController < ActionController::Base
    before_filter :authenticate_user!
  before_filter :set_tab
  layout 'application'

  def index
    @departments = Department.all.group_by(&:zone_id)
  end

  def new
    @department = Department.new

    respond_to do |format|
      format.html { render :action => "edit" }
      format.xml  { render :xml => @department }
    end
  end

  def create
    @department = Department.new(params[:department])

    respond_to do |format|
      if @department.save
        flash[:notice] = 'Department was successfully created.'
        format.html { redirect_to departments_path }
        format.xml  { head :ok }
        format.js { render :partial => "shared/update" }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @department.errors, :status => :unprocessable_entity }
        format.js {
          messages = @department.errors.collect { | error | error.join(' '); }
          message = messages.join(' <br /> ')
          render :json => message, :status => 444
        }
      end
    end
  end

  def edit
    @department = Department.find(params[:id])

    respond_to do |format|
      format.html
      format.xml  { render :xml => @department }
    end
  end

  def update
    @department = Department.find(params[:id])

    respond_to do |format|
      if @department.update_attributes(params[:department])
        flash[:notice] = 'Department was successfully updated.'
        format.html { redirect_to departments_path }
        format.xml  { head :ok }
        format.js { render :partial => "shared/update" }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @department.errors, :status => :unprocessable_entity }
        format.js {
          messages = @department.errors.collect { | error | error.join(' '); }
          message = messages.join(' <br /> ')
          render :json => message, :status => 444
        }
      end
    end
  end

  def destroy
    @department = Department.find(params[:id])

    respond_to do |format|
      if @department.destroy
        flash[:notice] = 'Department was successfully deleted.'
        format.html { redirect_to department_path }
        format.xml  { head :ok }
        format.js { render :partial => "shared/update" }
      else
        flash[:error] = @department.errors
        format.html { redirect_to department_path }
        format.xml  { render :xml => @department.errors, :status => :unprocessable_entity }
        format.js {
          messages = @department.errors.collect { | error | error.join(' '); }
          message = messages.join(' <br /> ')
          render :json => message, :status => 444
        }
      end
    end
  end

  private
  def set_tab
    @nav_tab = 'departments'
  end
end