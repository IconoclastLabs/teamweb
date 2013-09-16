Teamweb::Application.config.middleware.insert_before(Rack::Lock, Rack::Rewrite) do
  #rewrite '/fonts',  '/assets'
  rewrite %r{/fonts/(.*)}, '/assets/$1'
end