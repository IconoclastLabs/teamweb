# for Ubuntu
notification :libnotify

group :ruby do

  guard 'bundler' do
    watch('Gemfile')
    # Uncomment next line if Gemfile contain `gemspec' command
    # watch(/^.+\.gemspec/)
  end

  guard 'annotate' do
    watch( 'db/schema.rb' )

    # Uncomment the following line if you also want to run annotate anytime
    # a model file changes
    #watch( 'app/models/**/*.rb' )

    # Uncomment the following line if you are running routes annotation
    # with the ":routes => true" option
    #watch( 'config/routes.rb' )
  end

  guard :minitest do
    # with Minitest::Unit
    watch(%r{^lib/(.+)\.rb$})     { |m| "test/#{m[1]}_test.rb" }
    watch(%r{^test/.+_test\.rb$})
    watch('test/test_helper.rb')  { "test" }
    # Rails example
    watch(%r{^app/models/(.+)\.rb$})                   { |m| "test/unit/#{m[1]}_test.rb" }
    watch(%r{^app/controllers/(.+)\.rb$})              { |m| "test/functional/#{m[1]}_test.rb" }
    watch(%r{^app/views/.+\.rb$})                      { "test/integration" }
    watch('app/controllers/application_controller.rb') { ["test/functional", "test/integration"] }
  end

  guard :puma, :force_run => true, :port => 3000, :control_token => 'waffles' do
    watch('Gemfile.lock')
    watch(%r{^config|lib/.*})
  end

end

guard 'brakeman', :run_on_start => true, :quiet => true do
  watch(%r{^app/.+\.(erb|haml|rhtml|rb)$})
  watch(%r{^config/.+\.rb$})
  watch(%r{^lib/.+\.rb$})
  watch('Gemfile')
end