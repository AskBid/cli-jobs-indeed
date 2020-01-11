require 'bundler'

require 'open-uri'
require 'nokogiri'

require 'pry'

require_relative '../lib/jobsindeed_controller.rb'
require_relative '../lib/jobsindeed_scraper.rb'
require_relative '../lib/job.rb'
require_relative '../lib/search.rb'

Bundler.require

# require_all './lib'