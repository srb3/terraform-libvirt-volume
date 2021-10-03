require 'tempfile'

expected_base_volume_name = input('expected_base_volume_name')
expected_base_volume_pool = input('expected_base_volume_pool')
expected_main_volume_name = input('expected_main_volume_name')
expected_main_volume_pool = input('expected_main_volume_pool')
expected_main_volume_size = input('expected_main_volume_size')

main_temp = Tempfile.new
base_temp = Tempfile.new

bvn = expected_base_volume_name
bpn = expected_base_volume_pool
mvn = expected_main_volume_name
mpn = expected_main_volume_pool

main_temp << command("virsh vol-dumpxml #{mvn} --pool #{mpn} | xmllint -").stdout.gsub("\n", '').strip
base_temp << command("virsh vol-dumpxml #{bvn} --pool #{bpn} | xmllint -").stdout.gsub("\n", '').strip

main_temp.flush
base_temp.flush

describe xml(main_temp) do
  its('volume/name') { should eq [expected_main_volume_name] }
  its('volume/capacity') { should eq [expected_main_volume_size.to_s] }
end

describe xml(base_temp) do
  its('volume/name') { should eq [expected_base_volume_name] }
end
