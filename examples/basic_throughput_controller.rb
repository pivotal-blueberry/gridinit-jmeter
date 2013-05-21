$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'gridinit-jmeter'

test do
  threads count: 100 do

    think_time 5000,5000

    throughput_controller percent: 100 do
      transaction name: "TC_01", parent: true, include_timers: true
    end
        
  end
end.run(path: '/usr/share/jmeter/bin/', gui: true)