require_relative 'contact'
require 'sinatra'

get "/" do
  @crm_app_name = "My CRM"
  erb :index
end

get "/contacts" do
  @crm_app_name = "My CRM"

  @contacts = []
  @contacts << Contact.new("Yehuda", "Katz", "yehuda@example.com", "Developer")
  @contacts << Contact.new("Mark", "Zuckerberg", "mark@facebook.com", "CEO")
  @contacts << Contact.new("Sergey", "Brin", "sergey@google.com", "Co-Founder")

  erb :contacts
end

get "/contact/new" do
  p "Add New Contact"
end