module Gridinit
  module Jmeter

    class DSL
      def response_time_graph(params, &block)
        node = Gridinit::Jmeter::ResponseTimeGraph.new(params)
        attach_node(node, &block)
      end
    end

    class ResponseTimeGraph
      attr_accessor :doc
      include Helper

      def initialize(params={})
        params[:name] ||= 'ResponseTimeGraph'
        @doc = Nokogiri::XML(<<-EOS.strip_heredoc)
<ResultCollector guiclass="RespTimeGraphVisualizer" testclass="ResultCollector" testname="#{params[:name]}" enabled="true">
  <boolProp name="ResultCollector.error_logging">false</boolProp>
  <objProp>
    <name>saveConfig</name>
    <value class="SampleSaveConfiguration">
      <time>true</time>
      <latency>true</latency>
      <timestamp>true</timestamp>
      <success>true</success>
      <label>true</label>
      <code>true</code>
      <message>false</message>
      <threadName>true</threadName>
      <dataType>false</dataType>
      <encoding>false</encoding>
      <assertions>false</assertions>
      <subresults>false</subresults>
      <responseData>false</responseData>
      <samplerData>false</samplerData>
      <xml>false</xml>
      <fieldNames>false</fieldNames>
      <responseHeaders>false</responseHeaders>
      <requestHeaders>false</requestHeaders>
      <responseDataOnError>false</responseDataOnError>
      <saveAssertionResultsFailureMessage>false</saveAssertionResultsFailureMessage>
      <assertionsResultsToSave>0</assertionsResultsToSave>
      <bytes>true</bytes>
      <threadCounts>true</threadCounts>
      <sampleCount>true</sampleCount>
    </value>
  </objProp>
  <stringProp name="filename"/>
</ResultCollector>)
        EOS
        update params
        update_at_xpath params if params[:update_at_xpath]
      end
    end

  end
end
