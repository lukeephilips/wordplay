class String
  define_method('game_router') do |test_word, replacement_word, transformation, match|
    if match == "whole"
      self.whole_word_count(test_word, replacement_word, transformation)
    elsif match == "partial"
      self.partial_word_count(test_word, replacement_word, transformation)
    end
  end

  define_method('convert_input') do
    self.downcase().gsub(/[^\w\s]/,'')
  end

  define_method('whole_word_count') do |test_word, replacement_word, transformation|
    input_array = self.convert_input().split()
    if transformation == "count"
      input_array.count(test_word)
    elsif transformation == "replace"
      input_array.each() do |word|
        if word == test_word
          word = word.replace(replacement_word)
        end
      end
    input_array.join(" ")
    end
  end

  define_method('partial_word_count') do |test_word, replacement_word, transformation|
    if transformation == "count"
      self.convert_input().scan(test_word.convert_input()).length()
    elsif transformation == "replace"
      self.convert_input().gsub!(test_word.downcase(), replacement_word.downcase())
    end
  end
end
