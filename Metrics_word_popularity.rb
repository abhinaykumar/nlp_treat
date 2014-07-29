# Various metrics can be used in an attempt to 
# fingerprint authors.We might use the 
# average number of sentences per paragraph, for example.

# If a story’s top 100 words are mostly within 
# another story’s bottom 100 words, then 
# those stories are probably not very similar.

require 'treat'
include Treat::Core::DSL

# Parse More Than One Story – Collections
stories = collection'./story'
# Process the entire collection
stories.apply(:chunk, :segment, :tokenize, :category)
 
# Start off with an empty hash object
word_hash = {}
 
# Assign the word's frequency to its key in word_hash
# Note: frequency_of does perform #downcase internally,
# but iterating over a uniq downcased array prevents iterating over
# unnecessary instances in the story
downcased_words = stories.words.map { |word| word.to_s.downcase }.uniq
downcased_words.each do |w|
  word_hash[w] = stories.frequency_of(w)
end
 
# Create an array of [key, value] arrays, sorted greatest-to-least
word_popularity = word_hash.sort_by { |key, value| value }.reverse

p word_popularity


adjective_popularity = word_popularity.select do |key, value|
  key.category == "adjective"
end
p adjective_popularity