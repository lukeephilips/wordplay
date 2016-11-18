require('wordplay')
require('rspec')
require('pry')
require('./app')
require('capybara/rspec')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

# Integration tests
  # count words
describe('the WHOLE word COUNT path', {:type => :feature}) do
  it('processes user input and displays number of whole word matches') do
    visit('/')
    fill_in('sentence', :with => 'I am a cat. I am only a cat and not a cathode ray or a cathedral.')
    fill_in('test_word', :with => 'cat')
    select('Find whole-word matches', :from => 'match_select')
    click_button('Go')
    expect(page).to have_content('Your string cat appears 2 times in the sentence I am a cat. I am only a cat and not a cathode ray or a cathedral.')
  end
end
describe('the PARTIAL word COUNT path', {:type => :feature}) do
  it('processes user input and displays number of partial word matches') do
    visit('/')
    fill_in('sentence', :with => 'I am a cat. I am only a cat and not a cathode ray or a cathedral.')
    fill_in('test_word', :with => 'cat')
    select('Find partial-word matches', :from => 'match_select')
    click_button('Go')
    expect(page).to have_content('Your string cat appears 4 times in the sentence I am a cat. I am only a cat and not a cathode ray or a cathedral.')
  end
end
# replace words
describe('the PARTIAL word REPLACE path', {:type => :feature}) do
  it('processes user input and replaces partial word matches') do
    visit('/')
    fill_in('sentence', :with => 'I am a cat. I am only a cat and not a cathode ray or a cathedral.')
    fill_in('test_word', :with => 'cat')
    fill_in('replacement_word', :with => 'dog')
    select('Find partial-word matches', :from => 'match_select')
    select('Replace', :from => 'transformation_select')
    click_button('Go')
    expect(page).to have_content('i am a DOG i am only a DOG and not a DOGhode ray or a DOGhedral')
  end
end
describe('the WHOLE word REPLACE path', {:type => :feature}) do
  it('processes user input and replaces partial word matches') do
    visit('/')
    fill_in('sentence', :with => 'I am a cat. I am only a cat and not a cathode ray or a cathedral.')
    fill_in('test_word', :with => 'cat')
    fill_in('replacement_word', :with => 'dog')
    select('Find whole-word matches', :from => 'match_select')
    select('Replace', :from => 'transformation_select')
    click_button('Go')
    expect(page).to have_content('i am a DOG i am only a DOG and not a cathode ray or a cathedral')
  end
end

# Unit tests
  # Game router parent method
describe('String#game_router') do
  it('replaces partial stings if user selects WHOLE word REPLACE') do
    expect("Cat cathedral".game_router("cat","DOG","replace","whole-word",)).to(eq("DOG cathedral"))
  end
end
describe('String#game_router') do
  it('replaces partial stings if user selects PARTIAL word REPLACE') do
    expect("Cat cathedral".game_router("cat","DOG","replace","partial-word",)).to(eq("DOG DOGhedral"))
  end
end
describe('String#game_router') do
  it('runs whole word match if user selects WHOLE word COUNT') do
    expect("Cat cathedral".game_router("cat","","count","whole-word")).to(eq(1))
  end
end
describe('String#game_router') do
  it('runs partial word match if user selects PARTIAL word COUNT') do
        expect("Cat cathedral".game_router("cat","dog","count","partial-word",)).to(eq(2))
  end
end
  # convert input helper method to convert input to lowercasewith no non-word characters
# describe('String#convert_input') do
#   it('converts the user input to downcase with all non-word characters removed') do
#     expect("I have many pets, including a cat and a dog. Cats are funny pets. There are few pets funnier than a cat. Dogs are cool too. Much cooler than cats.".convert_input()).to(eq("i have many pets including a cat and a dog cats are funny pets there are few pets funnier than a cat dogs are cool too much cooler than cats"))
#   end
# end
  # Whole word helper method
describe('String#whole_word') do
  it('displays the number of times a word appears in the user input string as a whole word') do
    expect("I have many pets, including a cat and a dog. Cats are funny pets. There are few pets funnier than a cat. Dogs are cool too. Much cooler than cats.".whole_word('cool',"","count",)).to(eq(1))
  end
end
describe('String#whole_word_replace') do
  it('replaces Whole word occurances of string A with string B in input sentence') do
    expect("Cat cathedral".whole_word('cat',"dog","replace")).to(eq("DOG cathedral"))
  end
end
  # Partial word helper method
describe('String#partial_word') do
  it('displays the number of times a substring appears in the user input string') do
    expect("I have many pets, including a cat and a dog. Cats are funny pets. There are few pets funnier than a cat. Dogs are cool too. Much cooler than cats.".partial_word('cat',"","count",)).to(eq(4))
  end
end
describe('String#partial_word_replace') do
  it('replaces instances of subtring A with substring B') do
    expect("Cat cathedral".partial_word('cat',"dog","replace",)).to(eq("DOG DOGhedral"))
  end
end
