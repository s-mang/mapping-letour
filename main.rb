require 'sinatra'
require File.dirname(__FILE__)+'/route'

set :public_folder, File.dirname(__FILE__) + '/assets'

get '/route/:year' do
	@points, @places = get_route(params[:year])
  	erb :route
end

get '/loop' do
	loop_routes
	"Done!"
end