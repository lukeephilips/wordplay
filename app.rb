require('./lib/wordplay')
require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')

get ('/') do
  erb(:index)
end

get('/wordplay') do
  @sentence = params.fetch('sentence')
  @test_word = params.fetch('test_word')
  @transformation = params.fetch('transformation_select')
  @match = params.fetch('match_select')

  @output = params.fetch('sentence').game_router(params.fetch('test_word'), params.fetch('replacement_word'), params.fetch('transformation_select'),params.fetch('match_select'))

  if @transformation == "count"
    erb(:wordplay)
  elsif @transformation == "replace"
    erb(:replace)
  end
end
