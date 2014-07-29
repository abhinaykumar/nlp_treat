require 'treat'
include Treat::Core::DSL

story = document('./ex.txt')
p story.chunk
p story.paragraphs
p story.paragraphs.first.to_s
p story.paragraphs[3].to_s