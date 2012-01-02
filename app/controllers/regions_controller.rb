class RegionsController < ActionController::Base
  before_filter :authenticate_user!
  before_filter :set_tab
  layout 'application'

  def index
    @regions = Region.all
  end

  def new
    @region = Region.new

    respond_to do |format|
      format.html { render :action => "edit" }
      format.xml  { render :xml => @region }
    end
  end

  def create
    @region = Region.new(params[:region])

    respond_to do |format|
      if @region.save
        flash[:notice] = 'Region was successfully created.'
        format.html { redirect_to regions_path }
        format.xml  { head :ok }
        format.js { render :partial => "shared/update" }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @region.errors, :status => :unprocessable_entity }
        format.js {
          messages = @region.errors.collect { | error | error.join(' '); }
          message = messages.join(' <br /> ')
          render :json => message, :status => 444
        }
      end
    end
  end

  def edit
    @region = Region.find(params[:id])

    respond_to do |format|
      format.html
      format.xml  { render :xml => @region }
    end
  end

  def update
    @region = Region.find(params[:id])

    respond_to do |format|
      if @region.update_attributes(params[:region])
        flash[:notice] = 'Region was successfully updated.'
        format.html { redirect_to regions_path }
        format.xml  { head :ok }
        format.js { render :partial => "shared/update" }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @region.errors, :status => :unprocessable_entity }
        format.js {
          messages = @region.errors.collect { | error | error.join(' '); }
          message = messages.join(' <br /> ')
          render :json => message, :status => 444
        }
      end
    end
  end

  def destroy
    @region = Region.find(params[:id])

    respond_to do |format|
      if @region.destroy
        flash[:notice] = 'Region was successfully deleted.'
        format.html { redirect_to region_path }
        format.xml  { head :ok }
        format.js { render :partial => "shared/update" }
      else
        flash[:error] = @region.errors
        format.html { redirect_to region_path }
        format.xml  { render :xml => @region.errors, :status => :unprocessable_entity }
        format.js {
          messages = @region.errors.collect { | error | error.join(' '); }
          message = messages.join(' <br /> ')
          render :json => message, :status => 444
        }
      end
    end
  end

  private
  def set_tab
    @nav_tab = 'regions'
  end
end