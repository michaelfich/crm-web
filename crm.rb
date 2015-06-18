require_relative 'rolodex'
require_relative 'contact'
require 'sinatra'

@@rolodex = Rolodex.new
@@rolodex.add_contact(Contact.new("Yehuda", "Katz", "yehuda@example.com", "Developer"))
@@rolodex.add_contact(Contact.new("Mark", "Zuckerberg", "mark@facebook.com", "CEO"))
@@rolodex.add_contact(Contact.new("Sergey", "Brin", "sergey@google.com", "Co-Founder"))

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
  notes = params['notes']

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

