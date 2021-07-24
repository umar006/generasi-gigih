require_relative '../models/item'
require_relative '../models/category'
require_relative 'application_controller'

class ItemsController < Application

  get '/' do
    @items = Item::all_with_categories
    erb :'items/index'
  end

  get '/items/new' do
    @categories = Category::all
    erb :'items/create'
  end

  post '/items/create' do
    Item::add(params['name'], params['price'], params['categories'])
    redirect '/'
  end

  get '/items/:id' do
    @item = Item::show(params['id'])
    erb :'items/show'
  end

  get '/items/:id/edit' do
    @item = Item::show(params['id'])
    @categories = Category::all
    
    erb :'items/edit'
  end

  post '/items/:id/update' do
    Item::update(params['id'], params['name'], params['price'], params['categories'])
    redirect '/'
  end

  post '/items/:id/destroy' do
    Item::delete(params['id'])
    redirect '/'
  end
  
end