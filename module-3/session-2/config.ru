require 'sinatra'
require_relative 'config/environment'
require_relative 'app/controllers/items_controller'
require_relative 'app/controllers/application_controller'

use ItemsController
run Application