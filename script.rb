require_relative 'status_changer'

def timer(number_of_minutes)
  number_of_minutes ||= 5
  number_of_seconds = 60 * number_of_minutes.to_i
  time_back = (Time.now + number_of_seconds).strftime("%l:%M").strip
  away_message = "I'll be back at #{time_back}."

  puts "Changing Hipchat status to 'Do not disturb' until #{time_back}."
  UserSetter.new("dnd", away_message)
  sleep number_of_seconds
  UserSetter.new("chat")
  `while :; do afplay -t 60 #{File.dirname(__FILE__) + "/Submarine.aiff"}; done`
end

timer(ARGV[0])
