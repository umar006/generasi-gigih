require 'sinatra/base'
require_relative '../models/item'
require_relative '../models/category'
require_relative './items_controller'

class Application < Sinatra::Base
  configure do
    set :views, 'app/views'
  end

  # Items
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
    @item = Item::find_by_id(params['id'])
    erb :'items/show'
  end

  get '/items/:id/edit' do
    @item = Item::find_by_id(params['id'])
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

  # Categories
  get '/categories' do
    @categories = Category::all
    erb :'categories/index'
  end

  get '/categories/new' do
    erb :'categories/create'
  end

  post '/categories/create' do
    Category::add(params['name'])
    redirect '/categories'
  end

  get '/categories/:id' do
    @category = Category::find_by_id(params['id'])
    @items = Category::items_by_category(params['id'])
    erb :'categories/show'
  end

  get '/categories/:id/edit' do
    @category = Category::find_by_id(params['id'])
    erb :'categories/edit'
  end

  post '/categories/:id/update' do
    Category::update(params['id'], params['name'])
    redirect '/categories'
  end

  post '/categories/:id/destroy' do
    Category::delete(params['id'])
    redirect '/categories'
  end
end