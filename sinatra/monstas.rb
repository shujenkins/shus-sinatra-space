require "sinatra"
require "erb"
enable :sessions

#get "/" do
#  "OMG, hello Ruby Monstas!"
#end

#get "/monstas/:name" do
#  "Hello #{params["name"]}!"
#end

#get "/monstas/:name" do
#  params.inspect
#end

#get '/monstas/:name' do
#  ERB.new("<h1>Hello <%= params[:name] %></h1>").result(binding)
#end

#get '/monstas/:name' do
#  erb "<h1>Hello <%= name %></h1>", { :locals => { :name => params[:name] } }
#end

#get '/monstas/:name' do
#  erb "<h1>Hello <%= name %></h1>", { :locals => params }
#end

#get '/monstas/:name' do
#  template = "<h1>Hello <%= name %></h1>"
#  layout   = "<html><body><%= yield %></body></html>"
#  erb template, { :locals => params, :layout => layout }
#end

#get '/monstas/:name' do
#  erb :monstas, { :locals => params, :layout => :layout }
#end

#get '/monstas/:name' do
#  erb :monstas, { :locals => params, :layout => true }
#end

#get '/monstas/:name' do
#  erb :monstas, { :locals => params }
#end
def store_name(filename, string)
  File.open(filename, "a+") do |file|
    file.puts(string)
  end
end

get "/monstas/:name" do
  @message = session.delete(:message)
  @name = params["name"]
  #p params
  @names = read_names
  store_name("names.txt", @name)
  erb :monstas
end

post "/monstas" do
  @name = params["name"]
  store_name("names.txt", @name)
  session[:message] = "Successfully stored the name #{@name}."
  redirect "/monstas?name=#{@name}"
end

def read_names
  return [] unless File.exist?("names.txt")
  File.read("names.txt").split("\n")
end

# This snippet doesn't seem to work!
#get '/monstas/' do
#  erb :monstas
#end