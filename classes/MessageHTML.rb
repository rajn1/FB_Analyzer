class MessageHTML

  require "rubygems"
  require "nokogiri"
  require "open-uri"

  def initialize(messageNum)
    @messageNum = messageNum
  end

  def import
    initFile = File.open("C:/Users/RajNa/Documents/Facebook/messages/" << @messageNum.to_s << ".html") { |f| Nokogiri::HTML(f) }
    return initFile
  end

  def import_messages
    file = import
    messages = file.css("div").select{|x| x['class'] == "message"}
    return messages
  end

  def message_count
    messages = import_messages
    puts messages.length
  end

  def message_sender
    file = import
    @@sender = file.css("title").text.split[2,4].join(" ")
  end

end
