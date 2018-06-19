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

    return result
  end

  def character_count
    messages = @data['messages']

    my_char = 0
    other_char = 0
    messages.each do |m|
      begin
        if m["sender_name"] =~ /raj/i
          my_char = my_char + m["content"].size
        else
          other_char = other_char + m["content"].size
        end

      rescue
        next
      end

    end
    @percentMe = my_char.to_f / other_char.to_f * 100.0
  end

end



me = MessageJSON.new("ChiSigma_8e87c202f6")
me.import
me.my_sent
me.character_count
puts me.instance_variable_get(:@percentMe)
