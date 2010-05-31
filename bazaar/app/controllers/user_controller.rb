class UserController < ApplicationController

def login
  if request.post?
    member = Member.authenticate(params[:username], params[:password])
  if member
    session[:member_id] = member.id
    session[:user_type] = member.userType
    session[:member_name] = member.fname
	#redirect_to(:controller => "Application", :action => "startup" )
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

  else
  flash.now[:notice] = "Invalid user/password combination"
  end
  end

end

  def logout
      session[:member_id] = nil
      session[:member_name] = nil
      flash[:notice] = "You are now logged out"
      redirect_to(:action => "login" )
  end

def forgot
    if request.post?
      @member = Member.find_by_email(params[:email])
      if Member.find_by_email(params[:email])
        @member.create_reset_code
        email1 = OrderMailer.create_lostpassword(@member)
       render(:text => "<pre>" + email1.encoded + "</pre>" )

        flash[:notice] = "Rest Code sent to #{@member.email}"
      else
        flash[:notice] = "#{params[:email]} does not exist in the system"
      end
    end
  end

  def reset
      @member = Member.find_by_ResetCode(params[:reset_code]) unless [:reset_code].nil?
       flash[:notice] = "Enter your new password"
      if request.post?


        if params[:password] == params[:ConfirmPassword]
          @member.password=(params[:password])
          @member.delete_reset_code
          redirect_to(:controller => 'user', :action => 'login')
          flash[:notice] = "Password was reset"
        else
          flash[:notice] = "Passwords do not match"
        end
      end
  end


  def index
  end

end
