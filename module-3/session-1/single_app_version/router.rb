require 'sinatra'
require './db/db_connector'
require './app/models/item'
require './app/models/category'
require './app/controllers/items_controller'

configure do
  set :views, 'app/views'
end

# Get all items with categories
get '/' do
  @items = get_all_item_with_categories
  erb :index
end

# Add new item
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

# Show detail item
get '/items/:id' do
  id = params['id'].to_i
  @item = get_detail_item(id)
  erb :show
end

# Edit new item
get '/items/:id/edit' do
  id = params['id']
  @item = get_detail_item(id)
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

# Delete item
post '/items/:id/destroy' do
  id = params['id']
  destroy_item(id)
  redirect '/'
end
