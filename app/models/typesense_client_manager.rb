require "singleton"

class TypesenseClientManager
  include Singleton
  
  class << self
    delegate_missing_to :instance
  end

  attr_reader :client
  
  def initialize
    @client = Typesense::Client.new(
      nodes: [{
        host: TypesenseConfig.host,
        port: 8108,
        protocol: "http"
      }],
      api_key: TypesenseConfig.api_key,
      connection_timeout_seconds: 2
    )
  end
end
