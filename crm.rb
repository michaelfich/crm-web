require 'sinatra'
require 'data_mapper'

DataMapper::setup(:default, 'sqlite:crm.sqlite3')

class Contact
  include DataMapper::Resource

  property :id, Serial
  property :first_name, String
  property :last_name, String
  property :email, String
  property :note, Text

  DataMapper.finalize
  DataMapper.auto_upgrade!
end

get "/" do
  @@crm_app_name = "My CRM"
  redirect to '/contacts'
end

get "/contacts" do
  @contacts = Contact.all
  erb :contacts
end

get "/contacts/new" do
  erb :new_contact
end

post "/contacts" do
  first_name = params['first_name'].capitalize
  last_name = params['last_name'].capitalize
  email = params['email'].downcase
  notes = params['note']

  contact = Contact.create(
    first_name: first_name,
    last_name: last_name,
    email: email,
    note: notes
  )

  redirect to '/contacts'
end

get "/contacts/:id" do
  @id = params['id'].to_i
  @contact = Contact.get(@id)

  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end

get "/contacts/:id/edit" do
  @id = params['id'].to_i
  @contact = Contact.get(@id)

  if @contact
    erb :edit_contact
  else
    raise Sinatra::NotFound
  end
end

put "/contacts/:id" do
  id = params['id'].to_i
  first_name = params['first_name'].capitalize
  last_name = params['last_name'].capitalize
  email = params['email'].downcase
  note = params['note']

  contact = Contact.get(id)

  if contact
    contact.update(
      first_name: first_name,
      last_name: last_name,
      email: email,
      note: note
    )

    redirect to '/contacts'
  else
    raise Sinatra::NotFound
  end
end

delete "/contacts/:id" do
  @id = params['id'].to_i
  contact = Contact.get(@id)

  if contact
    contact.destroy
    redirect to '/contacts'
  else
    raise Sinatra::NotFound
  end
end

