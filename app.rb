require "sinatra"
require "sisimai"
require "sisimai/fact"
require "oj"

require_relative "lib/classifier"

set :host,        "0.0.0.0"
set :port,        3000
set :environment, "production"

post "/" do
  request.body.rewind
  result = classify(request.body.read)

  status 200
  headers \
    "Content-Type" => "application/json"
  body result.to_json
end
