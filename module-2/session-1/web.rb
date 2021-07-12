require 'sinatra'
require 'sinatra/reloader' if development?

get '/message' do
  erb :message, locals: {
    color: 'DodgerBlue',
    name: 'World!'
  }
  "<h1>Hello world!</h1>"
end

get '/message/:name' do
  name = params['name']
  color = params['color'] ? params['color'] : 'DodgerBlue'
  erb :message, locals: {
    color: color,
    name: name
  }
  "<h1 style=\"background-color: #{color};\">Hello #{params['name']}!</h1>"
end

get '/login' do
  erb :login
end

post '/login' do
  if params['username'] == 'admin' && params['password'] == 'admin'
    'Logged in!'
  else
    redirect '/login'
  end
end

items_arr = []
get '/items' do
  erb :items, locals: {
    items: items_arr
  }
end

post '/items' do
  items_arr << params['item_name']
  redirect '/items'
end