source "https://rubygems.org"

git_source(:github) { |name| "https://github.com/#{name}.git" }

gem "sinatra"
gem "sisimai", "~> 5.2.0"
gem "puma"
gem "rackup"

group :test do
  gem "rspec"
  gem "rack-test"
end

group :development, :test do
  gem "debug"
end
