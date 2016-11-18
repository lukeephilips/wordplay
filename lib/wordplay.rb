class String
  define_method('convert_input') do
    self.downcase().gsub(/[^\w\s]/,'')
  end

  define_method('whole_word_count') do |test|
    input_array = self.convert_input().split()
    input_array.count(test)
  end

  define_method('partial_word_count') do |test|
    self.convert_input().scan(test.convert_input()).length()
  end
end
