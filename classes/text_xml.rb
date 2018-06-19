class TextXML

  require 'json'
  require 'net/http'
  require 'active_support'
  require 'active_support/core_ext'

  def initialize
    @data = nil
  end

  # type 1 = Recieved, 2 = sent
  # Sample text: {"protocol"=>"0", "address"=>"", "date"=>"1464988056175", "type"=>"1", "subject"=>"null",
  # "body"=>"", "toa"=>"null", "sc_toa"=>"null", "service_center"=>"null", "read"=>"1", "status"=>"-1", "locked"=>"0",
  # "date_sent"=>"1464988055000", "readable_date"=>"Jun 3, 2016 17:07:36", "contact_name"=>""}
  def import

    s = File.open("C:/Users/RajNa/Google Drive/2018/sms-2018_06_19.xml")
    raw_data = Hash.from_xml(s).to_json
    data = JSON.parse(raw_data)
    data = data["smses"]["sms"]

    messages = Hash.new { |h, k| h[k] = [] }

    data.each do |text|
      begin

        messages[text["contact_name"]] << [text["date"], text["body"], text["type"]]

      rescue
        next
      end

    end
    @data = messages
    return messages
  end

  # Outputs character split between me and person I messaged by Contact name
  def message_split(name)
    messages = @data[name]

    char_me = 0
    char_them = 0

    messages.each do |msg|
      begin
        if msg[2].to_i == 2
          char_me = char_me + msg[1].size
        else
          char_them = char_them + msg[1].size
        end
      rescue
        next
      end
    end

    puts "My char count: #{char_me} | Their char count: #{char_them}"

  end

  # Outputs character split between me and all people I message
  def total_char_split
    messageData = @data
    output = []

    char_me = 0
    char_them = 0

    messageData.each do |name, messages|

      messages.each do |message|
        if message[2].to_i == 2
          char_me = char_me + message[1].size
        else
          char_them = char_them + message[1].size
        end
      end
      output << [name, char_me, char_them]
      char_me = 0
      char_them = 0
    end
    return output

  end


end

a = TextXML.new()
a.import
puts a.total_char_split
