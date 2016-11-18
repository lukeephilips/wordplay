require('wordplay')
require('rspec')
require('pry')
require('./app')
require('capybara/rspec')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

# Integration tests
describe('the whole word count path', {:type => :feature}) do
  it('processes user input and displays number of whole word matches') do
    visit('/')
    fill_in('sentence', :with => 'I am a cat. I am only a cat and not a cathode ray or a cathedral.')
    fill_in('test_word', :with => 'cat')
    select('Find whole-word matches', :from => 'game_select')
    click_button('Go')
    expect(page).to have_content('Your string cat appears 2 times in the sentence I am a cat. I am only a cat and not a cathode ray or a cathedral.')
  end
  it('processes user input and displays number of whole word matches') do
    visit('/')
    fill_in('sentence', :with => 'I am a cat. I am only a cat and not a cathode ray or a cathedral.')
    fill_in('test_word', :with => 'cat')
    select('Find partial-word matches', :from => 'game_select')
    click_button('Go')
    expect(page).to have_content('Your string cat appears 4 times in the sentence I am a cat. I am only a cat and not a cathode ray or a cathedral.')
  end
end

# Unit tests
describe('String#game_router') do
  it('runs whole word match if user selects whole word match') do
    expect("Cat cathedral".game_router("cat","whole")).to(eq(1))
  end
end
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
