require_relative 'rolodex'
require_relative 'contact'
require 'sinatra'

$rolodex = Rolodex.new
$rolodex.add_contact(Contact.new("Yehuda", "Katz", "yehuda@example.com", "Developer"))
$rolodex.add_contact(Contact.new("Mark", "Zuckerberg", "mark@facebook.com", "CEO"))
$rolodex.add_contact(Contact.new("Sergey", "Brin", "sergey@google.com", "Co-Founder"))

get "/" do
  @crm_app_name = "My CRM"
  erb :index
end

get "/contacts" do
  @crm_app_name = "My CRM"


  erb :contacts
end

get "/contacts/new" do
  erb :new_contact
end