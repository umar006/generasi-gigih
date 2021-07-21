class Application < Sinatra::Base
  configure do
    set :views, 'app/views'
  end

end