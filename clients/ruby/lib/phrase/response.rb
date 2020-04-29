module Phrase
  class Response
    attr_reader :data

    def initialize(data, headers)
      @data = data
      @paginated = false
      @next_page = nil

      link_headers = headers["link"]
      if link_headers
        @paginated = true
        parsed_links = LinkHeaderParser.parse(link_headers, base: 'https://api.phrase.com').by_relation_type
        next_page_link = parsed_links[:next]&.first
        if next_page_link
          @next_page = CGI.parse(URI.parse(next_page_link.target_uri).query)["page"]&.first&.to_i
        end
      end
    end

    def method_missing(method, *args, &block)
      if data.respond_to?(method)
        data.send(method, *args, &block)
      else
        super
      end
    end

    def next_page
      @next_page
    end

    def next_page?
      paginated? && !next_page.nil?
    end

    def paginated?
      @paginated
    end
  end
end
