require 'uri'

module ConfigHelper

  def self.postgres
    databases = {}

    ENV.to_hash.each do |key,value|
      begin
        uri = URI.parse(value)
        next unless uri.respond_to?(:scheme) && uri.scheme == "postgres"
        if databases.has_key? value
          databases[value][:labels] << key
        else
          databases[value] = {
            labels: [key],
            host: uri.host,
            port: uri.port,
            user: uri.user,
            password: uri.password,
            dbname: uri.path.split('/')[1],
            sslmode: 'require'
          }
        end
      rescue URI::InvalidURIError
      end
    end

    databases.each do |uri,hash|
      hash[:label] = hash[:labels]
        .sort_by(&:length)
        .map { |s| s.gsub /(_URL|HEROKU_POSTGRESQL_|_DATABASE)/, '' }
        .join(", ")
    end

    databases.values
  end

end

class Object
  def postgres_config ; ConfigHelper.postgres ; end
end
