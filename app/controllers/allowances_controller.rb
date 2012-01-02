class AllowancesController < ActionController::Base
  before_filter :authenticate_user!
  before_filter :set_tab
  layout 'application'

  def index
    @allowances = Allowance.all
  end

  def new
    @allowance = Allowance.new

    respond_to do |format|
      format.html { render :action => "edit" }
      format.xml  { render :xml => @allowance }
    end
  end

  def create
    @allowance = Allowance.new(params[:allowance])

    respond_to do |format|
      if @allowance.save
        flash[:notice] = 'Allowance was successfully created.'
        format.html { redirect_to allowances_path }
        format.xml  { head :ok }
        format.js { render :partial => "shared/update" }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @allowance.errors, :status => :unprocessable_entity }
        format.js {
          messages = @allowance.errors.collect { | error | error.join(' '); }
          message = messages.join(' <br /> ')
          render :json => message, :status => 444
        }
      end
    end
  end

  def edit
    @allowance = Allowance.find(params[:id])

    respond_to do |format|
      format.html
      format.xml  { render :xml => @allowance }
    end
  end

  def update
    @allowance = Allowance.find(params[:id])

    respond_to do |format|
      if @allowance.update_attributes(params[:allowance])
        flash[:notice] = 'Allowance was successfully updated.'
        format.html { redirect_to allowances_path }
        format.xml  { head :ok }
        format.js { render :partial => "shared/update" }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @allowance.errors, :status => :unprocessable_entity }
        format.js {
          messages = @allowance.errors.collect { | error | error.join(' '); }
          message = messages.join(' <br /> ')
          render :json => message, :status => 444
        }
      end
    end
  end

  def destroy
    @allowance = Allowance.find(params[:id])

    respond_to do |format|
      if @allowance.destroy
        flash[:notice] = 'Allowance was successfully deleted.'
        format.html { redirect_to allowance_path }
        format.xml  { head :ok }
        format.js { render :partial => "shared/update" }
      else
        flash[:error] = @allowance.errors
        format.html { redirect_to allowance_path }
        format.xml  { render :xml => @allowance.errors, :status => :unprocessable_entity }
        format.js {
          messages = @allowance.errors.collect { | error | error.join(' '); }
          message = messages.join(' <br /> ')
          render :json => message, :status => 444
        }
      end
    end
  end

  private
  def set_tab
    @nav_tab = 'allowances'
  end
end