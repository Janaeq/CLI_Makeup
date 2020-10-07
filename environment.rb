# connects our whole program so our files can talk to one another
# require all gems needed 

require 'pry'
require 'net/http'
require 'json'

require_relative './lib/api'
require_relative './lib/cli'
require_relative './lib/makeup'