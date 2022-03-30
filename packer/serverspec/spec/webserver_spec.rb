require 'spec_helper'

describe package('python3') do
  it { should be_installed }
end

describe file('/opt/flask-hello-world') do
  it { should be_directory }
end

describe port(80) do
  it { should be_listening }
end

