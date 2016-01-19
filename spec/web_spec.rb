require 'spec_helper'

describe 'chef-docker-tutorial::web' do
  cached(:chef_run) do
    ChefSpec::SoloRunner.converge(described_recipe)
  end

  it 'compiles the resource_collection' do
    expect(chef_run).to create_docker_service('default')

    expect(chef_run).to create_directory('/bob')
    expect(chef_run).to create_file('/bob/Dockerfile')
    expect(chef_run).to create_file('/bob/file')

    expect(chef_run).to build_if_missing_docker_image('bob/web').with(
      source: '/bob',
      tag: 'latest',
      force: true
    )

    expect(chef_run).to run_docker_container('bob').with(
      repo: 'bob/web',
      command: 'nginx -g "daemon off;"',
      port: '80:80'
    )
  end
end
