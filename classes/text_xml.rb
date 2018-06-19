class TextXML

  require 'json'
  require 'net/http'
  require 'active_support'
  require 'active_support/core_ext'

  def initialize
    @data = nil
  end

  # type 1 = Recieved, 2 = sent
  def import

    s = File.open("C:/Users/RajNa/Google Drive/2018/sms-2018_06_19.xml")
    raw_data = Hash.from_xml(s).to_json
    data = JSON.parse(raw_data)
    @data = data
    return data
  end

end

a = TextXML.new()
a.import
puts a.instance_variable_get(:@data)