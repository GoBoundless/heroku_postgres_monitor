require 'uri'
require 'ostruct'

module ConfigHelper

  ENV_REGEXP = /^HEROKU_POSTGRESQL_(?<color>[A-Z]+)_(?<attribute>NAME|URL)/

  def databases
    databases = {}
    ENV.each do |key,value|
      match = ENV_REGEXP.match(key) or next
      databases[match[:color].downcase.to_sym] ||= {}
      databases[match[:color].downcase.to_sym][match[:attribute].downcase.to_sym] = value
    end
    databases
  end

  def agents
    databases.each do |color,attributes|
      uri = URI.parse(attributes[:url])
      agent = OpenStruct.new
      agent.color = color
      agent.host = uri.host
      agent.port = uri.port
      agent.user = uri.user
      agent.password = uri.password
      agent.dbname = attributes[:name] || color
      agent.name = attributes[:name] || color
      yield agent
    end
  end

end
