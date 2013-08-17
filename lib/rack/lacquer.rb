require 'nokogiri'

module Rack
  class Lacquer
    
    def initialize app
      @app = app
    end

    def call env
      @env = env.deep_dup
      status, headers, response = @app.call env
      response.map! { |part| process_includes part } if headers['Content-Type'] =~ /text\/html/ && response.respond_to?( :map! )
      [status, headers, response]
    end
    
    def process_includes part
      document = Nokogiri::HTML part.to_s
      document.css('include').each do |esi|
        status, headers, response = @app.call env_for(esi['src'])
        esi.after response.join
        esi.remove
      end
      document.to_s
    end
    
    def env_for path_with_query
      path_info, query_string = path_with_query.split('?')
      @env.deep_dup.merge({
        'PATH_INFO' => path_info,
        'REQUEST_URI' => path_with_query,
        'QUERY_STRING' => query_string.to_s
      })
    end
    
  end
end
