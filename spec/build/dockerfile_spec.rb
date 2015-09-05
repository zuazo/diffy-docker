require_relative '../spec_helper'

describe 'Dockerfile build' do
  it 'creates image' do
    expect(image).not_to be_nil
  end

  it 'runs java in foreground' do
    expect(image_config['Entrypoint']).to include 'java'
  end

  it 'has Diffy path as workdir' do
    expect(image_config['WorkingDir']).to eq '/opt/diffy'
  end
end
