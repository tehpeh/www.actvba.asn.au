require 'sinatra'

configure do
  set :public_folder, File.join(File.dirname(__FILE__), '_site')
end
set :static_cache_control, [:public, :max_age => 36000]

configure :production do
  before do
    if request.host =~ /^(?!www\.)/ && request.host != "vba.heroku.com"
      redirect request.url.sub(request.host, "www.#{request.host}"), 301
    end
    cache_control :public, :max_age => 86400
  end
end

get '/' do
  send_file File.join(settings.public, 'index.html')
end

not_found do
  status 404
  "Not found"
end

error do
  status 500
  "Server error"
end