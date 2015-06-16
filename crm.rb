require_relative 'rolodex'
require_relative 'contact'
require 'sinatra'

$rolodex = Rolodex.new

get "/" do
  @crm_app_name = "My CRM"
  erb :index
end

get "/contacts" do
  @crm_app_name = "My CRM"

  $rolodex.add_contact(Contact.new("Yehuda", "Katz", "yehuda@example.com", "Developer"))
  $rolodex.add_contact(Contact.new("Mark", "Zuckerberg", "mark@facebook.com", "CEO"))
  $rolodex.add_contact(Contact.new("Sergey", "Brin", "sergey@google.com", "Co-Founder"))

  erb :contacts
end

get "/contact/new" do
  p "Add New Contact"
end