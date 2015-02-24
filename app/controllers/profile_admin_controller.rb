class ProfileAdminController < AdminbaseController 
  def index
    list
    render :action => 'list'
  end

  # !!! LJG depricated ? does not work in rails 4
  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  #verify :method => :post, :only => [ :destroy, :create, :update ],
  #       :redirect_to => { :action => :list }

  def list
    @profiles = Profile.paginate :page => params[:page]
    # @profiles = Profile.find(:all)
  end

  def show
    @profile = Profile.find(params[:id])
  end

  def new
    @profile = Profile.new
    @buoys = []
  end

  def create
    @profile = Profile.new(params[:profile])
    if @profile.save
      flash[:notice] = 'Profile was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def update_add_buoys
    profile = Profile.find(params[:id])
    buoys = params[:buoy];
    buoys.each do |b|
#    puts  "buoy: #{b} \n";
     # find the record for that buoy
     buoy = Station.find(:first,
     :conditions => ["number = :number", {:number => b}]);
  #   puts "add buoy #{buoy.name} to prof #{profile.id} \n";
  #   puts "insert #{buoy.name} (#{buoy.id}) into #{profile.name} (#{profile.id})\n"
     profile.add_buoy(buoy);
     
     
    end
  
  end

  def add_buoys
    @profile = Profile.find(params[:id])
    buoys = Station.find(:all);
    @buoys = [];
    buoys.each do |buoy|
      inc = true;
      buoy.profiles.each do |prof|
   #     puts "buoy #{buoy.name} is in prof #{prof.profile_id} #{prof.name} == #{@profile.id} my prof ?"
        if (prof.profile_id.to_i == @profile.id)
    #      puts "no include\n"
          inc = false;
        else
     #     puts "what?  #{prof.profile_id.class} #{@profile.id.class} \n"  
        end
      end
      if inc
        @buoys << buoy;
      end
    end
  end

  def edit
    @profile = Profile.find(params[:id])
    @buoys = @profile.stations
    puts "req: #{request.env['HTTP_USER_AGENT']} \n"; 
  end

  def update
    @profile = Profile.find(params[:id])
    buoys = params[:buoy];
    if (buoys)
      buoys.each do |b|
        station = @profile.stations.find(:first, 
         :conditions => ["number = :number",{:number => b}])
        if (station)
          @profile.stations.delete(station)
        end     
      end
    end  
    if @profile.update_attributes(params[:profile])
      flash[:notice] = 'Profile was successfully updated.'
      redirect_to :action => 'show', :id => @profile
    else
      render :action => 'edit'
    end
  end

  def destroy
    Profile.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
