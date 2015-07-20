#
# Cookbook Name:: myiis-cookbook
# Recipe:: audit_recipe
#

control_group "IIS Audit" do
  control "IIS" do
    it "should be installed" do
      expect(windows_feature("IIS-WebServerRole")).to be_installed
    end

    it "should be running" do
      expect(service("w3svc")).to be_running
    end

    it "should be listening on port 80" do
      expect(port(80)).to be_listening
    end
  end

  describe 'wwwroot should exist' do
    describe file('c:/inetpub/wwwroot') do
      it { should be_directory }
    end
  end

  describe command('dir c:/inetpub') do
    its(:exit_status) { should eq 0 }
  end
end

