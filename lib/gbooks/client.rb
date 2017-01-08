module Gbooks
  class Client
    class ConnectionError < StandardError; end

    attr_reader :base_uri

    def initialize
      @base_uri = 'https://www.googleapis.com/books/v1'
    end

    def search_volumes(search)
      endpoint = "#{base_uri}/volumes?q=#{search}"

      uri = URI(URI.encode(endpoint))
      response = Net::HTTP.get_response(uri)

      raise ConnectionError if response.code != 200

      response.body
    end
  end
end
