class Main

  require './message_json.rb'
  require './text_xml'
  require './call_xml'
  require 'csv'

  # Run through all FB Messages to synopsis by sender
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

    return overall

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

  def write_to_csv(data)

    CSV.open("C:/Users/RajNa/RubymineProjects/FB_Analyzer/FBdata.csv", "w") do |csv|

      data.each do |x|
        csv << x
      end

    end
  end


end

a = Main.new

puts a.write_to_csv(a.JSON_FB_Analyser)