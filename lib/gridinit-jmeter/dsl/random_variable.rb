module Gridinit
  module Jmeter

    class DSL
      def random_variable(params={}, &block)
        node = Gridinit::Jmeter::RandomVariable.new(params)
        attach_node(node, &block)
      end
    end

    class RandomVariable
      attr_accessor :doc
      include Helper

      def initialize(params={})
        params[:name] ||= 'RandomVariable'
        @doc = Nokogiri::XML(<<-EOS.strip_heredoc)
<RandomVariableConfig guiclass="TestBeanGUI" testclass="RandomVariableConfig" testname="#{params[:name]}" enabled="true">
  <stringProp name="maximumValue"/>
  <stringProp name="minimumValue">1</stringProp>
  <stringProp name="outputFormat"/>
  <boolProp name="perThread">false</boolProp>
  <stringProp name="randomSeed"/>
  <stringProp name="variableName"/>
</RandomVariableConfig>)
        EOS
        update params
        update_at_xpath params if params[:update_at_xpath]
      end
    end

  end
end
