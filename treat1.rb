require 'treat'
include Treat::Core::DSL

story = document('./ex.txt')
# Run the chunker, segmenter, and tokenizer in succession.
story.apply(:chunk, :segment, :tokenize, :category)
 
#=> An array containing all of the story's Word objects
 
p story.words
#=> The first Word object in the first paragraph
p story.paragraphs.first.words.first
 
#=> The number of words in the first sentence of the first paragraph
p story.paragraphs[0].sentences[0].word_count

# This gets an object, not a string
p story.paragraphs.first
 
# This gets the actual text of the entire paragraph
p story.paragraphs.first.to_s
# This will print nothing
puts story.words.first
 
# This prints the first word
puts story.words.first.to_s

# Get an array of all Word objects that are nouns
p story.nouns
 
# Get an array of the lengths of all the verbs
p story.verbs.map { |v| v.to_s.length }
 
# Get the number of conjuctions used
p story.conjunction_count

# p story.sentences[8].to_s

# It’s important that the chunker does its job correctly because every 
# other processor depends on its results
# story.chunk
# Run the segmenter on the first paragraph
# story.paragraphs.first.segment
# p story.paragraphs.first.segment
#=> An array of sentences in the first paragraph
# p story.paragraphs.first.sentences
# p story.sentences


# p story.chunk
# p story.paragraphs
# p story.paragraphs.first.to_s
# p story.paragraphs[3].to_s