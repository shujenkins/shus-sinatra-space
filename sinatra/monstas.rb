require "sinatra"
require "erb"
enable :sessions

get "/" do
  "Shu's Sinatra Spot!!!!"
end

get '/monstas/:name' do
  @message = session.delete(:message)
  @name = params["name"]
  @names = read_names
  erb :monstas
end

def read_names
  return [] unless File.exist?("names.txt")
  File.read("names.txt").split("\n")
end

class NameValidator
  def initialize(name, names)
    @name = name.to_s
    @names = names
  end

  def valid?
    validate
    @message.nil?
  end

  def message
    @message
  end

  private

    def validate
      if @name.empty?
        @message = "You need to enter a name."
      elsif @names.include?(@name)
        @message = "#{@name} is already included in our list."
      end
    end
end

post '/monstas/:name' do
  @name = params["name"]
  @names = read_names
  validator = NameValidator.new(@name, @names)
    
  if validator.valid?
    store_name("names.txt", @name)
    session[:message] = "Successfully stored the name #{@name}."
    redirect "/monstas/monstas?name=#{@name}"
  else
    session[:message] = validator.message
    erb :monstas
  end
end

def store_name(filename, string)
  File.open(filename, "a+") do |file|
    file.puts(string)
  end
end