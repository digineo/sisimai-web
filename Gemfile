source "https://rubygems.org"

git_source(:github) { |name| "https://github.com/#{name}.git" }

gem "sinatra"
gem "sisimai", "~> 5.0.2"
gem "webrick"

group :test do
  gem "rspec"
  gem "rack-test"
end

group :development, :test do
  gem "pry-byebug"
end
