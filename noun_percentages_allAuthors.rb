# !/usr/bin/env ruby
 
require 'pathname'
require 'treat'
include Treat::Core::DSL
 
def process_collection(path)
  puts "Author: #{Pathname.new(path).basename}"
  paths = Dir.glob(path + "/*")
  paths.each do |story_path|
    story = document story_path
    story.apply(:chunk, :segment, :tokenize, :category)
    noun_percentage = (story.noun_count / story.word_count.to_f).round(2)
    puts "#{Pathname.new(story_path).basename}: #{noun_percentage}"
  end
  puts ""
end
 
process_collection './story'
process_collection './story1'
process_collection './story2'
# process_collection 'collections/philip_k_dick'
# process_collection 'collections/news'