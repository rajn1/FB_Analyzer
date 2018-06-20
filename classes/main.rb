class Main

  require './message_json.rb'
  require './text_xml'
  require './call_xml'

  # Run through all FB Messages to synopsize by sender
  def JSON_FB_Analyser



    #overall = [["Title", "Count", "Char - Me", "Char - Other", "% Me", "Call Time"]]
    overall = []
    Dir.foreach('C:/Users/RajNa/Documents/Facebook_JSON/messages') do |item|

      begin

        next if item == '.' or item == '..'
        msg = MessageJSON.new(item.to_s, "raj")
        msg.calc_all_individual
        overall << [msg.title, msg.count, msg.charMe, msg.charOther, msg.percentMe, msg.callTime]

      rescue
        next
      end
    end

    puts overall

  end

  # Calculate total messages/chars
  def JSON_FB_Totals

    overall = JSON_FB_Analyser
    overall.delete(0)

    total_messages = 0
    total_char_me = 0
    total_char_other = 0

    overall.each do |msg|
      total_messages = total_messages + msg[1]
      total_char_me = total_char_me + msg[2]
      total_char_other = total_char_other + msg[3]
    end

    puts "Messages: #{total_messages}"
    puts "Char Me: #{total_char_me}"
    puts "Char Other: #{total_char_other}"

  end


end

a = Main.new

puts a.JSON_FB_Analyser