require 'sinatra'

before do
  cache_control :public, :max_age => 86400
end

get '/' do
  send_file File.join(settings.public, 'vba_home.html')
end

not_found do
  status 404
  "Not found"
end

error do
  status 500
  "Server error"
end