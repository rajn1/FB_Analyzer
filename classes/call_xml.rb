class CallXML


  require 'json'
  require 'net/http'
  require 'active_support'
  require 'active_support/core_ext'

  def initialize
    @data = nil
  end

  # type 1 = Recieved, 2 = sent
  def import

    s = File.open("C:/Users/RajNa/Google Drive/2018/calls-2018_06_19.xml")
    raw_data = Hash.from_xml(s).to_json
    data = JSON.parse(raw_data)
    @data = data["calls"]["call"]
    return data
  end

end

a = CallXML.new()
a.import
puts a.instance_variable_get(:@data)