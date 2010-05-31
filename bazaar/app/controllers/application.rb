# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  #before_filter :authorize, :except => :login
  helper :all # include all helpers, all the time
  
#  def startup
#    render :partial => "partials/home"
#  end

  def startup
    @user = Member.find_by_id(session[:member_id])
    if @user
      if @user.userType == 1
        render :partial => "partials/admin", :layout => "application"
      else
        render :partial => "partials/user", :layout => "application"
      end
      
    else
      render :partial => "partials/public", :layout => "application"
    end
  end
  def admin_or_user(param)
  if param.class == Item
          unless session[:user_type] == 1 || session[:member_id] == param.seller_id
       flash[:notice] = "YOUR NOT AN ADMIN"
       redirect_to :controller => 'user' , :action => 'login'
       end
  end
  if param.class == Member
      unless session[:user_type] == 1 || session[:member_id] == param.id
       flash[:notice] = "YOUR NOT AN ADMIN"
       redirect_to :controller => 'user' , :action => 'login'
       end
  end

end


  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '70eec9c37c1d800e0e01f0afe72eb927'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

  protected
def authorize
unless Member.find_by_id(session[:member_id])
  flash[:notice] = "Please log in"
  redirect_to :controller => 'user' , :action => 'login'
end
end
  def isAdmin
    unless session[:user_type] == 1
      flash[:notice] = "YOUR NOT AN ADMIN"
       redirect_to :controller => 'user' , :action => 'login'
    end
  end
end
