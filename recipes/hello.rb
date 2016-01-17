docker_service 'default' do
  action [:create, :start]
end

docker_image 'hello-world' do
  action :pull_if_missing
end

docker_container 'hello-world' do
  action :run_if_missing
end
