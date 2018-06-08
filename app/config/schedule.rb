# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

set :environment, "#{ENV['RACK_ENV']}"
# set :output, {:error => "log/cron_log.log", :standard => "log/cron_log.log"}

# every 10.minutes do
#   rake 'cron:whitelisting'
# end

# every 1.day, :at => '06:00 pm' do
#   rake 'cron:syncing'
# end

# every 1.day, :at => '10:00 am' do
#   rake 'cron:kyc_follow_up'
# end
