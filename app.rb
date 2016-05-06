require 'sinatra'
require 'sinatra/activerecord'
require './config/environments' #database configuration
require './models/cat'

before do
		@pride ||= Cat.all
end

# index - display a list of all cats
get '/cats' do
	haml :index
end

# new - return a form for creating a new cat
get '/cats/new' do
	haml :new
end

# create - create a new cat
post '/cats' do
	@cat = Cat.new(name: params[:name], age: params[:age])
		if @cat.save
				redirect '/cats'
		else
			"Sorry, there was an error!"
		end	
end

# show - show a specific cat
get '/cats/:id' do
	@cat = Cat.find_by_id(params[:id])
	#puts @cat.inspect
	haml :show
end

# edit - return a form to edit a specific cat
get '/cats/:id/edit' do
	@cat = Cat.find_by_id(params[:id])
	haml :edit
end

# update - update a specific cat
patch '/cats/:id' do
	@cat = Cat.find_by_id(params[:id])
  @cat.name = params[:name]
  @cat.age = params[:age]
  if @cat.save
  	redirect to "/cats/#{@cat.id}"
  else
  	"Sorry, there was an error!"
  end	
end

# destroy - delete a specific cat
delete '/cats/:id/delete' do
	@cat = Cat.find_by_id(params[:id])
  @cat.delete
  redirect to '/cats'
end
