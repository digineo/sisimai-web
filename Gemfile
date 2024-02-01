source "https://rubygems.org"

git_source(:github) { |name| "https://github.com/#{name}.git" }

gem "sinatra"
gem "sisimai", github: "sisimai/rb-sisimai", ref: "v4.25.16p1"
gem "webrick"

group :test do
  gem "rspec"
  gem "rack-test"
end

group :development, :test do
  gem "pry-byebug"
end
