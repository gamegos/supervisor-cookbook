# Inspec test for recipe gamegos-supervisor::test

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

if os.family == 'debian'
  supervisor_bin_directory = '/usr/local/bin'
  python_package = 'python2.7'
elsif os.family == 'redhat'
  supervisor_bin_directory = '/usr/bin'
  python_package = 'python'
end

describe package(python_package) do
  it { should be_installed }
end

describe pip('supervisor') do
  it { should be_installed }
end

describe service('supervisor') do
  it { should be_running }
end

describe file("#{supervisor_bin_directory}/supervisord") do
  it { should exist }
end

describe file("#{supervisor_bin_directory}/supervisorctl") do
  it { should exist }
end

describe file('/etc/supervisor/supervisord.conf') do
  it { should exist }
end

describe command('supervisord -h') do
  its(:stdout) { should match 'supervisord -- run a set of applications as daemons.' }
  its('exit_status') { should eq 0 }
end

describe command('supervisorctl -h') do
  its(:stdout) { should match 'supervisorctl -- control applications run by supervisord from the cmd line' }
  its('exit_status') { should eq 0 }
end

%w[cat vi].each do |process|
  describe file("/etc/supervisor/program_#{process}.conf") do
    it { should exist }
  end

  describe file("/etc/supervisor/group_#{process}.conf") do
    it { should exist }
  end

  describe command("supervisorctl status #{process}") do
    its(:stdout) { should match "#{process} *STOPPED\s" }
    its('exit_status') { should eq 0 }
  end

  describe command("supervisorctl start #{process}") do
    its(:stdout) { should match "#{process}: started" }
    its('exit_status') { should eq 0 }
  end

  describe command("supervisorctl status #{process}") do
    its(:stdout) { should match "#{process} *RUNNING\s" }
    its('exit_status') { should eq 0 }
  end

  describe command("supervisorctl stop #{process}") do
    its(:stdout) { should match "#{process}: stopped" }
    its('exit_status') { should eq 0 }
  end
end
