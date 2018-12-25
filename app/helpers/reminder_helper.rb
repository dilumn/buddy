# Search for reminders to notify on today
module ReminderHelper

  def self.today_reminders
    dilum_reminders = JSON.parse(File.read('json/dilum_reminders.json'))

    today = dilum_reminders.select { |reminder|
      reminder if  Date.today == Date.parse(reminder["date"])
    }
    today
  end

end
