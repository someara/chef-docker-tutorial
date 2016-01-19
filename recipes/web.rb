docker_service 'default' do
  action [:create, :start]
end

directory '/bob' do
  action :create
end

file '/bob/Dockerfile' do
  content <<-EOF
  FROM nginx
  MAINTAINER bob@computers.biz
  COPY file /usr/share/nginx/html/index.html
  EOF
  action :create
end

file '/bob/file' do
  content "bob was here\n"
  action :create
end

docker_image 'bob/web' do
  source '/bob'
  tag 'latest'
  force true
  subscribes :build, 'file[/bob/Dockerfile]'
  subscribes :build, 'file[/bob/file]'
  action :build_if_missing
end

docker_container 'bob' do
  repo 'bob/web'
  command 'nginx -g "daemon off;"'
  port '80:80'
  action :run
  subscribes :redeploy, 'docker_image[bob/web]'
end
