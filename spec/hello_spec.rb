require 'spec_helper'

describe 'chef-docker-tutorial::hello' do
  cached(:chef_run) do
    ChefSpec::SoloRunner.converge(described_recipe)
  end

  it 'compiles the resource_collection' do
    expect(chef_run).to create_docker_service('default')
    expect(chef_run).to pull_docker_image('hello-world')
    expect(chef_run).to run_docker_container('hello-world')
  end
end
