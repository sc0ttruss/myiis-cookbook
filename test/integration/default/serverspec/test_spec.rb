require 'spec_helper'

describe 'Host File' do
  describe file('c:/inetpub') do
    it { should be_directory }
  end
end

describe port(5985) do
  it { should be_listening }
end

