require "spec_helper"
require "serverspec"
require "nokogiri"

package = "dbus"
service = "dbus"
_user    = "messagebus"
_group   = "messagebus"
conf_dir = "/etc/dbus-1"
default_user = "root"
default_group = "root"
ports = []
xmllint_package = "libxml2-utils"

case os[:family]
when "redhat"
  xmllint_package = "libxml2"
when "openbsd"
  default_group = "wheel"
  service = "messagebus"
  xmllint_package = "libxml"
when "freebsd"
  conf_dir = "/usr/local/etc/dbus-1"
  default_group = "wheel"
  xmllint_package = "libxml2"
end
systemd_dir = "#{conf_dir}/system.d"
config = "#{conf_dir}/system-local.conf"

describe package(package) do
  it { should be_installed }
end

describe package(xmllint_package) do
  it { should be_installed }
end

describe file(config) do
  it { should exist }
  it { should be_file }
  it { should be_owned_by default_user }
  it { should be_grouped_into default_group }
  it do
    expect { Nokogiri::XML(subject.content) }.not_to raise_exception
  end
end

describe file("#{systemd_dir}/avahi-dbus.conf") do
  it { should exist }
  it { should be_file }
  it { should be_owned_by default_user }
  it { should be_grouped_into default_group }
  it { should be_mode 644 }
  it do
    expect { Nokogiri::XML(subject.content) }.not_to raise_exception
  end
  its(:content) { should match(/Managed by ansible/) }
end

describe service(service) do
  it { should be_running }
  it { should be_enabled }
end

ports.each do |p|
  describe port(p) do
    it { should be_listening }
  end
end
