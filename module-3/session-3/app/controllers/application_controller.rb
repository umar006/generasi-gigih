require 'sinatra/base'
require_relative '../models/item'
require_relative '../models/category'
require_relative './items_controller'
require_relative './categories_controller'

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
    ItemsController::create_item({
      name: params['name'],
      price: params['price'],
      category_name: params['categories']
    })
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
    ItemsController::update_item({
      id: params['id'],
      name: params['name'],
      price: params['price'],
      category_name: params['categories']
    })
    redirect '/'
  end

  post '/items/:id/destroy' do
    ItemsController::delete_item({id: params['id']})
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
    CategoriesController::create_category({
      category_name: params['name']
    })
    redirect '/categories'
  end

  get '/categories/:id' do
    @category = Category::find_by_id(params['id'])
    @items = Item::where(params['id'])
    erb :'categories/show'
  end

  get '/categories/:id/edit' do
    @category = Category::find_by_id(params['id'])
    erb :'categories/edit'
  end

  post '/categories/:id/update' do
    CategoriesController::update_category({
      category_id: params['id'],
      category_name: params['name']
    })
    redirect '/categories'
  end

  post '/categories/:id/destroy' do
    CategoriesController::delete_category({
      category_id: params['id']
    })
    redirect '/categories'
  end
end