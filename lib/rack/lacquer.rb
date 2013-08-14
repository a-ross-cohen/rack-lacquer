require 'nokogiri'

module Rack
  class Lacquer
    
    def initialize app
      @app = app
    end

    def call env
      status, headers, response = @app.call env
      response.map! { |part| process_includes part, env } if headers['Content-Type'] =~ /text\/html/ && response.respond_to?( :map! )
      [status, headers, response]
    end
    
    def process_includes part, env
      document = Nokogiri::HTML part.to_s
      document.css('include').each do |esi|
        path_info, query_string = esi['src'].split('?')
        include_status, include_headers, include_response = @app.call env.merge({
          'PATH_INFO' => path_info,
          'REQUEST_URI' => esi['src'],
          'QUERY_STRING' => query_string.to_s,
          'action_dispatch.request.parameters' => env['action_dispatch.request.parameters'].merge!( Rack::Utils.parse_nested_query query_string )
        })
        esi.after include_response.join
        esi.remove
      end
      document.to_s
    end
    
  end
end
