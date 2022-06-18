require 'sinatra'
Dir['controllers/*.rb'].each {|file| load file }
