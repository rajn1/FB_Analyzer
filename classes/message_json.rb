class MessageJSON

  require "rubygems"
  require "json"

  def initialize(name)
    @name = name
    @title = ""
    @count = 0
    @percentMe = 0
    @data = nil
  end

  def import
    messages_file = File.open("C:/Users/RajNa/Documents/Facebook_JSON/messages/" << @name.to_s << "/message.json")
    messages = File.read(messages_file)
    @data = JSON.parse(messages)
    @title = @data['title']
    @count = @data['messages'].length
    return @data

  end

  def my_sent

    data = @data["messages"]

    result = data.select do |hash|
      hash["sender_name"] =~ /raj/i
    end

    @percentMe = result.length.to_f / @count.to_f * 100.0

    return result
  end

  def character_count
    my_messages = my_sent
  end

end


