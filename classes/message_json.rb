class MessageJSON

  require "rubygems"
  require "json"

  def initialize(filename, myname)
    @filename = filename
    @myname = myname
    @title = ""
    @count = 0
    @percentMe = 0
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
    return time
  end

end



me = MessageJSON.new("xyz", "raj")
me.import
me.my_sent
me.character_count
puts me.total_call_time

#TODO
# Write Function to put all vars into Excel
# Write loop to go through all files
# Do more advanced analysis on conversation timeline
# Import SMS/Call Data (?)
#

