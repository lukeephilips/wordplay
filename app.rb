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
  @count = params.fetch('sentence').game_router(params.fetch('test_word'), params.fetch('replacement_word'), params.fetch('transformation_select'),params.fetch('match_select'))

  @match_type = params.fetch('match_select')
  erb(:wordplay)
end
