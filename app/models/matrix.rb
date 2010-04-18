class Matrix < ActiveRecord::Base
  belongs_to :culster
  belongs_to :user

  def addcluster(cluster_id, username)
    
    @userHash = Hash.new
    Cluster.find(cluster_id).users.each { |u|
      @userHash[u.name] = u
    }

    username.each { |user|
       if @userHash[user].nil?
         u = User.find(:first,:conditions => ["name = ?",user])
         break if u.nil?
         matrix = Matrix.new
         matrix.cluster_id = cluster_id
         matrix.user_id = u.id
         matrix.save
       end
    }
  end

  def addclusterfull(cluster_id, fulltxt)
    fulltxt.split(/[^a-zA-Z0-9_]/).each { |s|
      addcluster(cluster_id,s) unless s.blank?
    }
  end
end
