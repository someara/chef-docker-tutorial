docker_service 'default' do
  action [:create, :start]
end

docker_image 'alpine' do
  tag '3.1'
  action :pull
end

docker_container 'an_echo_server' do
  repo 'alpine'
  tag '3.1'
  command 'nc -ll -p 7 -e /bin/cat'
  port '7:7'
  action :run
end
