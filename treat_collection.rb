require 'treat'
include Treat::Core::DSL

# Parse More Than One Story – Collections
stories = collection './story'
# Process the entire collection
stories.apply(:chunk, :segment, :tokenize, :category)
 
# Gets the noun percentage out of all the stories to two decimal places
p (stories.noun_count.to_f / stories.word_count).round(2)
 
# Prints out the path of every story in the collection
stories.each_document do |story|
  puts story.file
end