require 'sinatra'
require './db_connector'
require './controller/item_controller'

get '/' do
  @items = get_all_item_with_categories
  erb :index
end

get '/items/new' do
  @categories = get_all_categories
  erb :create
end

post '/items/create' do
  name = params['name']
  price = params['price']
  category = params['categories']

  add_new_item(name, price, category)
  redirect '/'
end

get '/items/:id' do
  id = params['id'].to_i
  @items = get_detail_item(id)
  erb :show
end

get '/items/:id/edit' do
  id = params['id']
  @items = get_detail_item(id)
  @categories = get_all_categories
  
  erb :edit
end

post '/items/:id/update' do
  id = params['id']
  name = params['name']
  price = params['price']
  category = params['categories']

  update_item(id, name, price, category)
  redirect '/'
end

post '/items/:id/destroy' do
  id = params['id']
  destroy_item(id)
  redirect '/'
end
