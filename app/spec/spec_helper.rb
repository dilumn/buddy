# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

# uncomment to calculate the test coverage
# require 'simplecov'
# SimpleCov.start do
#   add_filter 'helpers/exception_notifier.rb'
#   add_filter 'lib/tasks/funds.rake'
#   add_filter 'lib/tasks/seeds.rake'
#   add_filter 'lib/tasks/seeds-stg.rake'
#   add_filter 'config/application.rb'
#   add_filter 'config/initializers/localization.rb'
#   add_filter 'config/initializers/rack_attack.rb'
#   add_filter 'api/endpoints/dev/health/health.rb'
#   add_filter 'config/initializers/sidekiq.rb'
#   add_filter 'mailers/exception_notifier_mailer.rb'
#   add_filter 'api/endpoints/dev/web/users/manage_phone_number.rb'
# end

require 'rack/test'
require 'json'
require 'base64'
require 'sidekiq/testing'

require File.expand_path('../../config/environment', __FILE__)

Dir[File.expand_path('../../lib/tasks/*', __FILE__)].each do |file|
  load file
end

Sidekiq::Testing.fake!

Rake::Task.define_task(:environment)

grape_starter_gem = Gem::Specification.find_by_name('grape-starter').gem_dir

Dir[grape_starter_gem + '/lib/starter/rspec/**/*.rb'].each { |f| require f }

HttpResponse = Struct.new(:code, :body)

ActionMailer::Base.delivery_method = :test

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.color = true
  config.formatter = :documentation

  config.mock_with :rspec do |mocks|
    mocks.verify_doubled_constant_names = true
  end
  config.expect_with :rspec

  config.raise_errors_for_deprecations!

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  # Stub saving of files to S3
  config.before(:each) do
    allow_any_instance_of(Paperclip::Attachment).to receive(:save).and_return(true)
    allow_any_instance_of(Paperclip::Storage::S3).to receive(:copy_to_local_file).and_return(nil)
  end

  # clear actionamiler of deliveries
  config.before(:each) do
    Sidekiq::Worker.clear_all
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end

def encode64(filepath, content_type, filename)
  hash = Hash.new
  hash[:data] = Base64.encode64(File.open(filepath, "rb").read)
  hash[:content_type] = content_type
  hash[:filename]     = filename
  hash
end


def app
  Api::Base
end
