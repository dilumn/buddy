require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

scheduler.every '1d' do
  p ReminderHelper.today_reminders
end
