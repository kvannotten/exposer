require "exposer/version"
require "exposer/hash"
require "net/http"
require 'net/ssh'
require "json"
require 'fileutils'
module Exposer
  
  def self.prepare
    Exposer.make_sure_has_key
    
    Exposer.get_host_details
  end
  
  def self.start options = {}
    raise "You need to prepare the tunnel first" if @response.nil?
    
    begin
      puts "Starting connection..."
      puts "#{@response.message}" if @response.member? 'message'
      
      Net::SSH.start("expose.exposer.io", "exposer") do |ssh|
        ssh.forward.remote(options.port.to_i, "localhost", @response.port.to_i, "0.0.0.0")
        puts "You can reach your service on #{@response.host}\n\n"
        puts "Press CTRL+C to stop the connection."
        ssh.loop { true }
      end
    rescue
      raise "An error occurred while creating the tunnel, please try again later."
      exit!
    end
  end
  
  def self.make_sure_has_key
    if not File.exists? File.expand_path("~/.exposer") then
      if not File.exists? File.expand_path("~/.ssh/id_rsa.pub") then
        raise "Could not find public key in ~/.ssh/id_rsa.pub"
        exit!
      else
        key = IO.read(File.expand_path("~/.ssh/id_rsa.pub"))
        response = JSON.parse(Net::HTTP.post_form(URI.parse("http://www.exposer.io/key"), { :key => key }).body)
        if response.member? "error" then
          raise "An error occurred while processing your public key: #{response.error}"
          exit!
        end
        File.open(File.expand_path("~/.exposer"), "w") { |f| f.write "1" } 
      end
    end
  end
  
  def self.get_host_details
    url = URI.parse("http://www.exposer.io/host")
    @response = JSON.parse(Net::HTTP.get(url))
    
    raise "An exception occurred: #{@response.error}" if @response.member? 'error'
  end
  
  def self.response
    @response
  end
  
end
