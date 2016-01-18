describe command('docker images') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(/^alpine\s.*3.1/) }
end

describe command('docker ps -af "name=an_echo_server"') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(/an_echo_server$/) }
end

describe command('netstat -anp | grep -i docker-proxy') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should_not match(/:::7/) }
end
