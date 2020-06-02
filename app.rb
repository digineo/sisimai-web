require "sinatra"
require "sisimai"
require "oj"

set :host,        "0.0.0.0"
set :port,        3000
set :environment, "production"

post "/" do
  request.body.rewind
  result, _ = Sisimai.make(request.body.read) || []

  status 200
  headers \
    "Content-Type" => "application/json"
  body result.to_json
end
