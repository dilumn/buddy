require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

scheduler.every '1d' do
  # Slack notification should come here
  ReminderHelper.today_reminders
end
