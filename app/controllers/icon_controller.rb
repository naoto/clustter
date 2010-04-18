class IconController < ApplicationController
  
  def list
    @users = User.find(:all)
    
    respond_to do |format|
      format.html
      format.xml { render :xml => @users }
    end
  end

end
