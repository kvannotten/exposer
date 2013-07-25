require "exposer/version"
require "exposer/hash"
require "net/http"
require 'net/ssh'
require "json"

module Exposer
  
  def self.prepare
    url = URI.parse("http://www.exposer.io/host")
    @response = JSON.parse(Net::HTTP.get(url))
    
    raise "An exception occurred: #{@response.error}" if @response.member? 'error'
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
  
end
