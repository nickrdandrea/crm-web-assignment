# Implement the new web-based CRM here.
# Do NOT copy the CRM class from the old crm assignment, as it won't work at all for the web-based version!
# You'll have to implement it from scratch.
require_relative 'contact'
require 'sinatra'

## Temporary fake data so that we always find contact with id 1.
Contact.create('Betty', 'Maker', 'betty@bitmakerlabs.com', 'Developer')
Contact.create('Tim', 'Maker', 'betty@bitmakerlabs.com', 'Developer')
Contact.create('Amy', 'Maker', 'betty@bitmakerlabs.com', 'Developer')

@@crm_app_name = "Nick's CRM"

get '/' do
  erb :contacts
end

get "/contacts" do
  erb :contacts
end

get "/contacts/new" do
  erb :new_contact
end

post '/contacts' do
  Contact.create(params[:first_name], params[:last_name], params[:email], params[:note])
  redirect to('/contacts')
end

get "/about" do
  erb :index
end

get '/contacts/:id' do
  @contact = Contact.find(params[:id].to_i)
  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end

get '/contacts/:id/edit' do
  @contact = Contact.find(params[:id].to_i)
  if @contact
    erb :edit_contact
  else
    raise Sinatra::NotFound
  end
end

put '/contacts/:id' do
  @contact = Contact.find(params[:id].to_i)
  if @contact
    @contact.first_name = params[:first_name]
    @contact.last_name = params[:last_name]
    @contact.email = params[:email]
    @contact.note = params[:note]

    redirect to('/contacts')
  else
    raise Sinatra::NotFound
  end
end
