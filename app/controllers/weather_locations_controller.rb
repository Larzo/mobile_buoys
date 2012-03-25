class WeatherLocationsController < AdminbaseController 
  # GET /weather_locations
  # GET /weather_locations.xml
  def index
    @weather_locations = WeatherLocation.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @weather_locations }
    end
  end

  # GET /weather_locations/1
  # GET /weather_locations/1.xml
  def show
    @weather_location = WeatherLocation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @weather_location }
    end
  end

  # GET /weather_locations/new
  # GET /weather_locations/new.xml
  def new
    @weather_location = WeatherLocation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @weather_location }
    end
  end

  # GET /weather_locations/1/edit
  def edit
    @weather_location = WeatherLocation.find(params[:id])
  end

  # POST /weather_locations
  # POST /weather_locations.xml
  def create
    @weather_location = WeatherLocation.new(params[:weather_location])

    respond_to do |format|
      if @weather_location.save
        flash[:notice] = 'WeatherLocation was successfully created.'
        format.html { redirect_to(@weather_location) }
        format.xml  { render :xml => @weather_location, :status => :created, :location => @weather_location }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @weather_location.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /weather_locations/1
  # PUT /weather_locations/1.xml
  def update
    @weather_location = WeatherLocation.find(params[:id])

    respond_to do |format|
      if @weather_location.update_attributes(params[:weather_location])
        flash[:notice] = 'WeatherLocation was successfully updated.'
        format.html { redirect_to(@weather_location) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @weather_location.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /weather_locations/1
  # DELETE /weather_locations/1.xml
  def destroy
    @weather_location = WeatherLocation.find(params[:id])
    @weather_location.destroy

    respond_to do |format|
      format.html { redirect_to(weather_locations_url) }
      format.xml  { head :ok }
    end
  end
end
