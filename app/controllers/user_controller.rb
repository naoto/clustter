class UserController < ApplicationController

  def details
     @name = params["id"]
     @user = User.find(:first ,:conditions => ["name = ?", @name])
     
     @friends = {}
     @user.clusters.each { |c|
       cluster = Cluster.find(:first, :conditions => ["name = ?",c.name])
       cluster.users.each { |u|
         ur = []
         ur = @friends[u.name] unless @friends[u.name].nil?
         ur << c.name
         @friends[u.name] = ur
       }
     }
     @friends = @friends.to_a.sort { |a,b| (b[1].size <=> a[1].size) * 2 + (a[0].size <=> b[0].size) }
  end

end
