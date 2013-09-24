Teamweb::Application.config.middleware.insert_before(Rack::Runtime, Rack::Rewrite) do
  #rewrite '/fonts',  '/assets'
  rewrite %r{/fonts/(.*)}, '/assets/$1'
  rewrite %r{/font/(.*)}, '/assets/$1'
end