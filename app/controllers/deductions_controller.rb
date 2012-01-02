class DeductionsController < ActionController::Base
    before_filter :authenticate_user!
  before_filter :set_tab
  layout 'application'

  def index
    @deductions = Deduction.all
  end

  def new
    @deduction = Deduction.new

    respond_to do |format|
      format.html { render :action => "edit" }
      format.xml  { render :xml => @deduction }
    end
  end

  def create
    @deduction = Deduction.new(params[:deduction])

    respond_to do |format|
      if @deduction.save
        flash[:notice] = 'Deduction was successfully created.'
        format.html { redirect_to deductions_path }
        format.xml  { head :ok }
        format.js { render :partial => "shared/update" }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @deduction.errors, :status => :unprocessable_entity }
        format.js {
          messages = @deduction.errors.collect { | error | error.join(' '); }
          message = messages.join(' <br /> ')
          render :json => message, :status => 444
        }
      end
    end
  end

  def edit
    @deduction = Deduction.find(params[:id])

    respond_to do |format|
      format.html
      format.xml  { render :xml => @deduction }
    end
  end

  def update
    @deduction = Deduction.find(params[:id])

    respond_to do |format|
      if @deduction.update_attributes(params[:deduction])
        flash[:notice] = 'Deduction was successfully updated.'
        format.html { redirect_to deductions_path }
        format.xml  { head :ok }
        format.js { render :partial => "shared/update" }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @deduction.errors, :status => :unprocessable_entity }
        format.js {
          messages = @deduction.errors.collect { | error | error.join(' '); }
          message = messages.join(' <br /> ')
          render :json => message, :status => 444
        }
      end
    end
  end

  def destroy
    @deduction = Deduction.find(params[:id])

    respond_to do |format|
      if @deduction.destroy
        flash[:notice] = 'Deduction was successfully deleted.'
        format.html { redirect_to deduction_path }
        format.xml  { head :ok }
        format.js { render :partial => "shared/update" }
      else
        flash[:error] = @deduction.errors
        format.html { redirect_to deduction_path }
        format.xml  { render :xml => @deduction.errors, :status => :unprocessable_entity }
        format.js {
          messages = @deduction.errors.collect { | error | error.join(' '); }
          message = messages.join(' <br /> ')
          render :json => message, :status => 444
        }
      end
    end
  end

  private
  def set_tab
    @nav_tab = 'deductions'
  end
end