require 'spec_helper'

describe 'chef-docker-tutorial::echo' do
  cached(:chef_run) do
    ChefSpec::SoloRunner.converge(described_recipe)
  end

  it 'compiles the resource_collection' do
    expect(chef_run).to create_docker_service('default')

    expect(chef_run).to pull_docker_image('alpine').with(
      tag: '3.1'
    )

    expect(chef_run).to run_docker_container('an_echo_server').with(
      repo: 'alpine',
      tag: '3.1',
      command: 'nc -ll -p 7 -e /bin/cat',
      port: '7:7'
    )
  end
end
