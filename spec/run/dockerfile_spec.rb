require_relative '../serverspec_helper'

describe 'Docker image run' do
  def docker_run_wait(secs)
    waited = $waited || 0
    wait = secs - waited
    if wait > 0
      sleep(wait)
      $waited = secs
    end
  end

  %w(curl git openssl).each do |app|
    describe package(app) do
      it { should be_installed }
    end

    it "has #{app} in the path" do
      expect(command("which #{app}").exit_status).to eq 0
    end
  end

  it 'has java installed' do
    expect(command('which java').exit_status).to eq 0
  end

  describe process('java') do
    it { should be_running }
  end

  %w(31900 31159 31149).each do |p|
    describe port(p) do
      it do
        docker_run_wait(5)
        should be_listening
      end
    end
  end

  it 'returns Diffy web page' do
    docker_run_wait(5)
    expect(command('curl -L http://localhost:31149').stdout).to include 'Diffy'
  end
end
