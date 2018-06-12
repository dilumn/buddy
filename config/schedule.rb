require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

scheduler.every '3s' do
  p ReminderHelper.today_reminders
end
