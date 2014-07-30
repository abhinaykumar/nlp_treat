require 'treat'
include Treat::Core::DSL

# Parse More Than One Story – Collections
Auth1 = collection './Auth1'
# Process the entire collection
Auth1.apply(:chunk, :segment, :tokenize, :category)
#
Auth2 = collection './Auth2'
Auth2.apply(:chunk, :segment, :tokenize, :category)

#
findAuth = document('./ex.txt')
findAuth.apply(:chunk, :segment, :tokenize, :category)
# Start off with an empty hash object
Auth1_word_hash = {}
Auth2_word_hash = {}
findAuth_word_hash = {}

# Assign the word's frequency to its key in word_hash
# Note: frequency_of does perform #downcase internally,
# but iterating over a uniq downcased array prevents iterating over
# unnecessary instances in the story
Auth1_downcased_words = Auth1.words.map { |word| word.to_s.downcase }.uniq
Auth1_downcased_words.each do |w|
  Auth1_word_hash[w] = Auth1.frequency_of(w)
end

# Create an array of [key, value] arrays, sorted greatest-to-least
Auth1_word_popularity = Auth1_word_hash.sort_by { |key, value| value }.reverse

Auth1_adjective_popularity = Auth1_word_popularity.select do |key, value|
  key.category == "adjective"
end
puts"Auth1 Adjectives::#{Auth1_adjective_popularity} "
puts "\n"
################################################################################

Auth2_downcased_words = Auth2.words.map { |word| word.to_s.downcase }.uniq
Auth2_downcased_words.each do |w|
  Auth2_word_hash[w] = Auth2.frequency_of(w)
end

# Create an array of [key, value] arrays, sorted greatest-to-least
Auth2_word_popularity = Auth2_word_hash.sort_by { |key, value| value }.reverse

Auth2_adjective_popularity = Auth2_word_popularity.select do |key, value|
  key.category == "adjective"
end
puts "Auth2 Adjectives::#{Auth2_adjective_popularity}"

Auth1_adjective_percentage = (Auth1.adjective_count / Auth1.word_count.to_f).round(2)
Auth2_adjective_percentage = (Auth2.adjective_count / Auth2.word_count.to_f).round(2)
puts "\n"
puts "% of Adjectives from Auth1:: #{Auth1_adjective_percentage * 100}%"
puts "% of Adjectives from Auth2:: #{Auth2_adjective_percentage * 100}%"

# ############################################################################
# FIND AUTHER ADJECTIVE
findAuth_downcased_words = findAuth.words.map { |word| word.to_s.downcase }.uniq
findAuth_downcased_words.each do |w|
  findAuth_word_hash[w] = findAuth.frequency_of(w)
end

# Create an array of [key, value] arrays, sorted greatest-to-least
findAuth_word_popularity = findAuth_word_hash.sort_by { |key, value| value }.reverse

findAuth_adjective_popularity = findAuth_word_popularity.select do |key, value|
  key.category == "adjective"
end
puts"Adjective for this Story :: #{findAuth_adjective_popularity} "
puts "\n"
puts "Wait looking for its Auther................"

# COUNT MATCH
matchAuth1 = (findAuth_adjective_popularity & Auth1_adjective_popularity )
match_count_Auth1 = matchAuth1.length

matchAuth2 = (findAuth_adjective_popularity & Auth2_adjective_popularity )
match_count_Auth2 = matchAuth2.length

# matchAuth1.adjective_count.to_f.round(2)
puts "....................................."
puts "#{match_count_Auth1}% match for Auth1"
puts "#{match_count_Auth2}% match for Auth2"

if match_count_Auth1 > match_count_Auth2
  puts "Probably Auther1 is the writter for this story with #{match_count_Auth1}% match."
else
  puts "Probably Auther2 is the writter for this story with #{match_count_Auth2}% match."
end
