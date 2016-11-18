class String
  define_method('game_router') do |test_word, replacement_word, transformation, match_type|
    if match_type == "whole-word"
      self.whole_word(test_word, replacement_word, transformation)
    elsif match_type == "partial-word"
      self.partial_word(test_word, replacement_word, transformation)
    end
  end

  define_method('whole_word') do |test_word, replacement_word, transformation|
    input_array = self.downcase().gsub(/[^\w\s]/,'').split()
    if transformation == "count"
      input_array.count(test_word.downcase().gsub(/[^\w\s]/,''))
    elsif transformation == "replace"
      input_array.each() do |word|
        if word.downcase().gsub(/[^\w\s]/,'') == test_word.downcase().gsub(/[^\w\s]/,'')
          word = word.replace(replacement_word).upcase!()
        end
      end
    input_array.join(" ")
    end
  end

  define_method('partial_word') do |test_word, replacement_word, transformation|
    if transformation == "count"
      self.downcase().gsub(/[^\w\s]/,'').scan(test_word.downcase().gsub(/[^\w\s]/,'')).length()
    elsif transformation == "replace"
      if replacement_word == ""
        replacement_word = "Please enter a replacement word!"
      else
        self.downcase().gsub(/[^\w\s]/,'').gsub!(test_word.downcase().gsub(/[^\w\s]/,''), replacement_word.downcase().gsub(/[^\w\s]/,'').upcase!())
      end
    end
  end
end
