require "sinatra"
require "sisimai"
require "sisimai/fact"
require "oj"

require_relative "./classifier"

module SisimaiWeb
  class App < Sinatra::Application
    set :host,        "0.0.0.0"
    set :port,        3001
    set :environment, "production"

    post "/" do
      result = SisimaiWeb.classify(raw_body)

      status 200
      headers "Content-Type" => "application/json"
      body result.to_json
    end

    private

    def raw_body
      body = request.body
      body = case body
      when StringIO
        body
      when Rack::Lint::Wrapper::InputWrapper
        body.instance_variable_get(:@input)
      else
        raise ArgumentError, "don't know how to access raw body"
      end

      body.tap(&:rewind).read
    end
  end
end
