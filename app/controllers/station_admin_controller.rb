class StationAdminController < AdminbaseController 
  def index
    list
    respond_to do |format|
      format.html { render action: 'list' }
      format.json { render action: 'list', format: 'json' }
    end
    
  end


  def json_list
    list
    puts 'in json list'
    render action: 'list', format: 'json'
  end
  
  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  #verify :method => :post, :only => [ :destroy, :create, :update ],
  #       :redirect_to => { :action => :list }

  def list
    #@station_pages, @stations = paginate :stations, :per_page => 10
    
    @stations = Station.paginate :page => params[:page]
    
  end

  def show
    @station = Station.find(params[:id])
  end

  def new
    @station = Station.new
  end

  def create
    @station = Station.new(params[:station])
    if @station.save
      flash[:notice] = 'Station was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @station = Station.find(params[:id])
  end

  def update
    @station = Station.find(params[:id])
    if @station.update_attributes(params[:station])
      flash[:notice] = 'Station was successfully updated.'
      redirect_to :action => 'show', :id => @station
    else
      render :action => 'edit'
    end
  end

  def destroy
    Station.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
