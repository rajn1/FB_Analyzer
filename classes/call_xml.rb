class CallXML


  require 'json'
  require 'net/http'
  require 'active_support'
  require 'active_support/core_ext'

  def initialize
    @data = nil
    @total = 0
  end

  # type 1 = Recieved, 2 = sent
  def import

    s = File.open("C:/Users/RajNa/Google Drive/2018/calls-2018_06_19.xml")
    raw_data = Hash.from_xml(s).to_json
    data = JSON.parse(raw_data)
    @data = data["calls"]["call"]
    return data
  end

  # Calculate call time by person
  def call_time

    info = Hash.new(0)

    @data.each do |call|
      @total = @total + call["duration"].to_i
      info[call["contact_name"]] = info[call["contact_name"]] + call["duration"].to_i
    end

    return info
  end

  # Organize data by person
  def call_time_array

    info = Hash.new([])

    @data.each do |call|
      info[call["contact_name"]] << [call["date"], call["duration"].to_i]
    end

    return info
  end

end
