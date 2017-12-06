require "spec_helper"
require "serverspec"
require "nokogiri"

package = "dbus"
service = "dbus"
config  = "/etc/dbus-1/system-local.conf"
_user    = "messagebus"
_group   = "messagebus"
default_user = "root"
default_group = "root"
ports = []
xmllint_package = "libxml"

case os[:family]
when "openbsd"
  default_group = "wheel"
  service = "messagebus"
when "freebsd"
  config = "/usr/local/etc/dbus-1/system-local.conf"
  default_group = "wheel"
  xmllint_package = "libxml2"
end

describe package(package) do
  it { should be_installed }
end

describe package(xmllint_package) do
  it { should be_installed }
end

describe file(config) do
  it { should be_file }
  it { should be_owned_by default_user }
  it { should be_grouped_into default_group }
  it do
    expect { Nokogiri::XML(subject.content) }.not_to raise_exception
  end
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
