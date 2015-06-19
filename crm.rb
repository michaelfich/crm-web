require 'sinatra'
require 'data_mapper'
require_relative 'rolodex'

DataMapper::setup(:default, 'sqlite:crm.sqlite3')

class Contact
  include DataMapper::Resource

  property :id, Serial
  property :first_name, String
  property :last_name, String
  property :email, String
  property :note, Text

  def initialize(first_name, last_name, email, note)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @note = note
  end

  DataMapper.finalize
  DataMapper.auto_upgrade!
end

get "/" do
  @@crm_app_name = "My CRM"
  redirect to('/contacts')
end

get "/contacts" do
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

  contact = Contact.new(first_name, last_name, email, notes)

  @@rolodex.add_contact(contact)

  redirect to('/contacts')
end

get "/contacts/:id" do
  @id = params['id'].to_i
  @contact = @@rolodex.find_contact(@id)

  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end

get "/contacts/:id/edit" do
  @id = params['id'].to_i
  @contact = @@rolodex.find_contact(@id)

  if @contact
    erb :edit_contact
  else
    raise Sinatra::NotFound
  end
end

put "/contacts/:id" do
  @id = params['id'].to_i
  @contact = @@rolodex.find_contact(@id)

  if @contact
    @contact.first_name = params['first_name']
    @contact.last_name = params['last_name']
    @contact.email = params['email']
    @contact.note = params['note']

    redirect to('/contacts')
  else
    raise Sinatra::NotFound
  end
end

delete "/contacts/:id" do
  @id = params['id'].to_i
  @contact = @@rolodex.find_contact(@id)

  if @contact
    @@rolodex.remove_contact(@contact)
    redirect to('/contacts')
  else
    raise Sinatra::NotFound
  end
end

