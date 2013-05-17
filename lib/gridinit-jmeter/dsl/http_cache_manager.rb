module Gridinit
  module Jmeter

    class DSL
      def http_cache_manager(params, &block)
        node = Gridinit::Jmeter::HttpCacheManager.new(params)
        attach_node(node, &block)
      end
    end

    class HttpCacheManager
      attr_accessor :doc
      include Helper

      def initialize(params={})
        params[:name] ||= 'HttpCacheManager'
        @doc = Nokogiri::XML(<<-EOS.strip_heredoc)
<CacheManager guiclass="CacheManagerGui" testclass="CacheManager" testname="#{params[:name]}" enabled="true">
  <boolProp name="clearEachIteration">false</boolProp>
  <boolProp name="useExpires">false</boolProp>
</CacheManager>)
        EOS
        update params
        update_at_xpath params if params[:update_at_xpath]
      end
    end

  end
end
