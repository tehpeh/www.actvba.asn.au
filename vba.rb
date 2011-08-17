require 'sinatra'

configure do
  set :public, File.join(File.dirname(__FILE__), '_site')
end

configure :production do
  require 'newrelic_rpm'

  before do
    puts "Host: #{request.host}"
    puts "URL: #{request.url}"
    if request.host !=~ /^www/
      puts "#{request.scheme}://www.#{request.host}#{request.path}"
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