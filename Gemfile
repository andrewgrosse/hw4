source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

gem "rails", "~> 7.1.3"
gem "puma", ">= 5.0"
gem "bcrypt", "~> 3.1.7"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Active Storage support for image uploads
gem "image_processing", ">= 1.2"
gem "aws-sdk-s3", require: false  # Uncomment if using S3 storage

group :development, :test do
  gem "sqlite3", "~> 1.4"
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  gem "tabulo"
  gem "web-console"
end

group :production do
  gem "pg"  # PostgreSQL for production
end

gem "importmap-rails", "~> 2.1"
