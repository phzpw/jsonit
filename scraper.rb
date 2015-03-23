require 'sinatra'
require "json"
require "net/http"

def input(prompt="", newline=false)
  prompt += "\n" if newline
  Readline.readline(prompt, true).squeeze(" ").strip
end

buffer = ""
source = Net::HTTP.get(URI("http://www.reddit.com/r/thank_mr_skeltal/.json"))
json = JSON.parse(source)
if json
json["data"]["children"].each { |node|
  u = node["data"]["url"]
  if u.include? "jpg" or u.include? "png" or u.include? "gif"
    p = node["data"]["permalink"]
    t = node["data"]["title"].gsub(/[']/, '\\\\\'')
    buffer += "<a href='http://reddit.com#{p}' title='#{t}' ><img src='#{u}' width='100%' /></a>\n"
  end
}
end

source = Net::HTTP.get(URI("http://www.reddit.com/r/ledootgeneration/.json"))
json = JSON.parse(source)
if json
json["data"]["children"].each { |node|
  u = node["data"]["url"]
  if u.include? "jpg" or u.include? "png" or u.include? "gif"
    p = node["data"]["permalink"]
    t = node["data"]["title"].gsub(/[']/, '\\\\\'')
    buffer += "<a href='http://reddit.com#{p}' title='#{t}' ><img src='#{u}' width='100%' /></a>\n"
  end
}
end


get '/' do
  buffer
end

