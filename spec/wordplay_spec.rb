require('wordplay')
require('rspec')
require('pry')

describe('String#convert_input') do
  it('converts the user input to downcase with all non-word characters removed') do
    expect("I have many pets, including a cat and a dog. Cats are funny pets. There are few pets funnier than a cat. Dogs are cool too. Much cooler than cats.".convert_input()).to(eq("i have many pets including a cat and a dog cats are funny pets there are few pets funnier than a cat dogs are cool too much cooler than cats"))
  end
end

describe('String#whole_word_count') do
  it('displays the number of times a word appears in the user input string as a whole word') do
    expect("I have many pets, including a cat and a dog. Cats are funny pets. There are few pets funnier than a cat. Dogs are cool too. Much cooler than cats.".whole_word_count('cool')).to(eq(1))
  end
end

describe('String#partial_word_count') do
  it('displays the number of times a substring appears in the user input string') do
    expect("I have many pets, including a cat and a dog. Cats are funny pets. There are few pets funnier than a cat. Dogs are cool too. Much cooler than cats.".partial_word_count('cat')).to(eq(4))
  end
end
