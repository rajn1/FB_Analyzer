class MessageJSON

  require "rubygems"
  require "json"

  def initialize(filename, myname)
    @filename = filename
    @myname = myname
    @title = ""
    @count = 0
    @percentMe = 0
    @callTime = 0
    @charMe = 0
    @charOther = 0
    @data = nil

  end

  def import
    messages_file = File.open("C:/Users/RajNa/Documents/Facebook_JSON/messages/" << @filename.to_s << "/message.json")
    messages = File.read(messages_file)
    @data = JSON.parse(messages)
    @title = @data['title']
    @count = @data['messages'].length
    return @data

  end

  def my_sent

    data = @data["messages"]

    result = data.select do |hash|
      hash["sender_name"] =~ /#{@myname}/i
    end

    return result
  end

  def character_count
    messages = @data['messages']

    my_char = 0
    other_char = 0
    messages.each do |m|
      begin
        if m["sender_name"] =~ /#{@myname}/i
          my_char = my_char + m["content"].size
        else
          other_char = other_char + m["content"].size
        end

      rescue
        next
      end

    end
    @percentMe = my_char.to_f / (other_char.to_f + my_char) * 100.0
    @charMe = my_char
    @charOther = other_char
  end

  # time data in seconds
  def total_call_time
    messages = @data['messages']
    time = 0
    messages.each do |m|
      begin
        if m["type"] == "Call"
          time = time + m["call_duration"].to_i
        end

      rescue
        next
      end

    end
    @callTime = time
    return time
  end

  def calc_all_individual
    import
    my_sent
    character_count
    total_call_time
  end

  def title
    return @title
  end

  def count
    return @count
  end

  def percentMe
    return @percentMe
  end

  def callTime
    return @callTime
  end

  def charMe
    return @charMe
  end

  def charOther
    return @charOther
  end

end


# run through all files
overall = [["Title", "Count", "Char - Me", "Char - Other", "% Me", "Call Time"]]
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


#TODO
# Write Function to put all vars into Excel
# Do more advanced analysis on conversation timeline
# Import SMS/Call Data (?)
#

