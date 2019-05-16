module ReminderHelper

  def self.today_reminders
    reminders = JSON.parse(File.read('json/dilum_reminders.json'))

    today = reminders.select { |reminder|
      reminder if  Date.today == Date.parse(reminder["date"])
    }
    today
  end

end
