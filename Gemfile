source "https://rubygems.org"

git_source(:github) { |name| "https://github.com/#{name}.git" }

gem "sinatra"
gem "sisimai", github: "sisimai/rb-sisimai", ref: "v5.0.1"
gem "webrick"

group :test do
  gem "rspec"
  gem "rack-test"
end

group :development, :test do
  gem "pry-byebug"
end
