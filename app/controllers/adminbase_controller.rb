class AdminbaseController < ApplicationController

  before_filter :check_login, :except => ['login','authorize']
  layout :determine_layout

  def login
  end  

  def authorize
    pw = params[:password]
    if (pw == 'bigfish12')
      session[:admin_logged_in] = true
    end
  end

  def check_login
    # login disabled (not required) 
  # logged_in = false  
    logged_in = true
    if session[:admin_logged_in] 
      logged_in = true
    end
    if !logged_in
      redirect_to :action => 'login', :controller => 'adminbase'
    end
  end

end