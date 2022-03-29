require 'spec_helper'

describe service('sssd') do  
    it { should be_running }
    it { should be_enabled }
end

describe file('/var/log/httpd') do
    it { should be_directory }
end

describe file('/etc/httpd/conf/httpd.conf') do
    it { should contain 'ServerName www\.example\.com' }
end

describe service('httpd') do  
    it { should be_running }
    it { should be_enabled }
end