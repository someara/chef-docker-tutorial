describe command('docker images') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(/^hello-world\s.*latest/) }
end

describe command('docker ps -af "name=hello-world"') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(/hello-world$/) }
end
