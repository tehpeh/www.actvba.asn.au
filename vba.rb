require 'sinatra'

DAY = 24*60*60

configure do
  set :public_folder, File.join(File.dirname(__FILE__), '_site')
  set :static_cache_control, [:public, :max_age => 1 * DAY]
end

configure :production do
  require 'newrelic_rpm'
  before do
    if request.host =~ /^(?!www\.)/ && request.host != "vba.herokuapp.com"
      redirect request.url.sub(request.host, "www.#{request.host}"), 301
    end
    cache_control :public, :max_age => 1 * DAY
  end
end

get '/' do
  send_file File.join(settings.public_folder, 'index.html')
end

not_found do
  status 404
  "Not found"
end

error do
  status 500
  "Server error"
end