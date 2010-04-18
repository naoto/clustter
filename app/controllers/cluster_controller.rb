class ClusterController < ApplicationController
  auto_complete_for :culster, :name
  skip_before_filter :verify_authenticity_token

  def top
    @clusters = Cluster.paginate(:page => params[:page], :per_page => 20, :order => 'id desc')
    respond_to do |format|
      format.html
      format.xml { render :xml => @clusters }
    end
  end

  def add

    if params[:id].nil?
      @cluster = Cluster.new
    else
      @cluster = Cluster.find(:first, :conditions => ["name = ?", params["id"]])
    end

    respond_to do |format|
      format.html
      format.xml { render :xml => @cluster }
    end
  end

  def create
    
    name = params[:cluster][:name]
    if !params[:cluster][:id].blank?
      cluster = Cluster.find(params[:cluster][:id])
      cluster.name = name
      cluster.save
    end

    
    if cluster.nil?
      cluster = Cluster.new
      cluster.name = name
      cluster.save
    end

    matrix = Matrix.new
    matrix.addclusterfull cluster.id, params[:cluster][:full]
    matrix.addcluster cluster.id, params[:twitter]

    redirect_to :controller => 'cluster', :action => 'top'
  end

  def auto_complete_for_user_name
    find_options = { 
      :conditions => [ "name LIKE ?", params[:user][:name] + '%' ], 
      :limit => 10, :order => 'name' }
    @items = User.find(:all, find_options)
    render :partial => 'auto_complete_for_user_name'
  end

end
