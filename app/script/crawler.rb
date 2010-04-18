require 'rubygems'
require 'hpricot'
require 'open-uri'
require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter => "mysql",
  :database => "clustter",
  :host => "localhost",
  :user => "root",
  :timeout => 5000
)

class User < ActiveRecord::Base
end

@base = "http://twitter.com/"
@checklist = Array.new

def getUserList(idname,name = nil,icon = nil)

  puts "GET => #{idname}"
  userlist = Array.new

  begin
  html = Hpricot(open(URI.escape("#{@base}#{idname}")))
  elem = html.search("#following_list/span/a")
  elem.each { |a|
    id = a.attributes['href'].gsub(/^\//,"")
    screen = a.attributes['title']
    img = ""
    a.search("img").each{ |image|
      img = image.attributes['src']
    }
    userlist.push [id,screen,img]
  }
  rescue Timeout::Error,StandardError
    puts "error"
  end
  
  @checklist.delete([idname, name, icon])
  userlist

end

def insertUpdate(userlist)

  userlist.each { |id,name,img|

    user = User.find(:first,:conditions => ["name = ?",id])
    if user.nil?
      user = User.new
      user.name = id
    end
    user.screen = name
    user.image = img
    user.save
    puts "  id => #{id}, name => #{name}"

  }

end

userlist = getUserList(ARGV[0])
@checklist.concat userlist
@checklist.each {|id,name,img|
  userlist = getUserList(id,name,img)
  @checklist.concat userlist
  insertUpdate(userlist)
}
