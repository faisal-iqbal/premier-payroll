class ZonesController < ActionController::Base
  before_filter :authenticate_user!
  before_filter :set_tab
  layout 'application'

  def index
    @zones = Zone.all.group_by(&:region_id)
  end

  def new
    @zone = Zone.new

    respond_to do |format|
      format.html { render :action => "edit" }
      format.xml  { render :xml => @zone }
    end
  end

  def create
    @zone = Zone.new(params[:zone])

    respond_to do |format|
      if @zone.save
        flash[:notice] = 'Zone was successfully created.'
        format.html { redirect_to zones_path }
        format.xml  { head :ok }
        format.js { render :partial => "shared/update" }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @zone.errors, :status => :unprocessable_entity }
        format.js {
          messages = @zone.errors.collect { | error | error.join(' '); }
          message = messages.join(' <br /> ')
          render :json => message, :status => 444
        }
      end
    end
  end

  def edit
    @zone = Zone.find(params[:id])

    respond_to do |format|
      format.html
      format.xml  { render :xml => @zone }
    end
  end

  def update
    @zone = Zone.find(params[:id])

    respond_to do |format|
      if @zone.update_attributes(params[:zone])
        flash[:notice] = 'Zone was successfully updated.'
        format.html { redirect_to zones_path }
        format.xml  { head :ok }
        format.js { render :partial => "shared/update" }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @zone.errors, :status => :unprocessable_entity }
        format.js {
          messages = @zone.errors.collect { | error | error.join(' '); }
          message = messages.join(' <br /> ')
          render :json => message, :status => 444
        }
      end
    end
  end

  def destroy
    @zone = Zone.find(params[:id])

    respond_to do |format|
      if @zone.destroy
        flash[:notice] = 'Zone was successfully deleted.'
        format.html { redirect_to zone_path }
        format.xml  { head :ok }
        format.js { render :partial => "shared/update" }
      else
        flash[:error] = @zone.errors
        format.html { redirect_to zone_path }
        format.xml  { render :xml => @zone.errors, :status => :unprocessable_entity }
        format.js {
          messages = @zone.errors.collect { | error | error.join(' '); }
          message = messages.join(' <br /> ')
          render :json => message, :status => 444
        }
      end
    end
  end

  private
  def set_tab
    @nav_tab = 'zones'
  end
end