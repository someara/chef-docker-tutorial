
describe command('docker images') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(%r{^bob\/web\s.*latest}) }
end

describe command('docker ps -af "name=bob"') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(/bob$/) }
end

describe command('curl localhost') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(/bob was here/) }
end
