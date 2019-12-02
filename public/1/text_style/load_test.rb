require 'yaml'
require 'pry'
source = File.dirname(__FILE__) + "/text_style.yml"

text_hash = YAML::load_file(source)
h = text_hash['reporter_editorial']
puts h
