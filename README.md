# ansible-role-dbus

Install and configure dbus

# Requirements

None

# Role Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `dbus_user` | User of `dbus` | `{{ __dbus_user }}` |
| `dbus_group` | Group of `dbus` | `{{ __dbus_group }}` |
| `dbus_package` | Package name of `dbus` | `{{ __dbus_package }}` |
| `dbus_service` | Service name of `dbus` | `{{ __dbus_service }}` |
| `dbus_conf_dir` | Path to configuration directory | `{{ __dbus_conf_dir }}` |
| `dbus_systemd_dir` | Path to `system.d` directory | `{{ dbus_conf_dir }}/system.d` |
| `dbus_conf_file` | Path to `system-local.conf` | `{{ dbus_conf_dir }}/system-local.conf` |
| `dbus_system_local_config` | Content of `system-local.conf` | See below |
| `dbus_systemd_config` | List of files under `system.d` directory. See below | `[]` |

## `dbus_system_local_config`

```xml
<!DOCTYPE busconfig PUBLIC "-//freedesktop//DTD D-Bus Bus Configuration 1.0//EN"
 "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
 <busconfig></busconfig>
```

## `dbus_systemd_config`

This variable is a list of dict that represents files under
`dbus_systemd_dir`.

| Key | Value | Mandatory? |
|-----|-------|------------|
| `name` | File name | yes |
| `state` | Either `present` or `absent` | yes |
| `content` | The content of the file | no |

## Debian

| Variable | Default |
|----------|---------|
| `__dbus_user` | `messagebus` |
| `__dbus_group` | `messagebus` |
| `__dbus_package` | `dbus` |
| `__dbus_conf_dir` | `/etc/dbus-1` |
| `__dbus_service` | `dbus.service` |

## FreeBSD

| Variable | Default |
|----------|---------|
| `__dbus_user` | `messagebus` |
| `__dbus_group` | `messagebus` |
| `__dbus_package` | `devel/dbus` |
| `__dbus_conf_dir` | `/usr/local/etc/dbus-1` |
| `__dbus_service` | `dbus` |

## OpenBSD

| Variable | Default |
|----------|---------|
| `__dbus_user` | `_dbus` |
| `__dbus_group` | `_dbus` |
| `__dbus_package` | `dbus` |
| `__dbus_conf_dir` | `/etc/dbus-1` |
| `__dbus_service` | `messagebus` |

## RedHat

| Variable | Default |
|----------|---------|
| `__dbus_user` | `messagebus` |
| `__dbus_group` | `messagebus` |
| `__dbus_package` | `dbus` |
| `__dbus_conf_dir` | `/etc/dbus-1` |
| `__dbus_service` | `dbus.service` |

# Dependencies

None

# Example Playbook

```yaml
- hosts: localhost
  roles:
    - ansible-role-dbus
  pre_tasks:
    - name: Create _avahi user
      user:
        name: _avahi
        state: present
      when:
        - ansible_os_family != 'FreeBSD'
        - ansible_os_family != 'OpenBSD'
    - name: Create wheel group
      group:
        name: wheel
        state: present
      when:
        - ansible_os_family != 'FreeBSD'
        - ansible_os_family != 'OpenBSD'

  vars:
    dbus_systemd_config:
      - name: foo.conf
        state: absent
      - name: avahi-dbus.conf
        state: present
        content: |
          <!DOCTYPE busconfig PUBLIC
                    "-//freedesktop//DTD D-BUS Bus Configuration 1.0//EN"
                    "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
          <busconfig>

            <!-- Only root or user _avahi can own the Avahi service -->
            <policy user="_avahi">
              <allow own="org.freedesktop.Avahi"/>
            </policy>
            <policy user="root">
              <allow own="org.freedesktop.Avahi"/>
            </policy>

            <!-- Allow anyone to invoke methods on Avahi server, except SetHostName -->
            <policy context="default">
              <allow send_destination="org.freedesktop.Avahi"/>
              <allow receive_sender="org.freedesktop.Avahi"/>

              <deny send_destination="org.freedesktop.Avahi"
                    send_interface="org.freedesktop.Avahi.Server" send_member="SetHostName"/>
            </policy>

            <!-- Allow everything, including access to SetHostName to users of the group "wheel" -->
            <policy group="wheel">
              <allow send_destination="org.freedesktop.Avahi"/>
              <allow receive_sender="org.freedesktop.Avahi"/>
            </policy>
            <policy user="root">
              <allow send_destination="org.freedesktop.Avahi"/>
              <allow receive_sender="org.freedesktop.Avahi"/>
            </policy>
          </busconfig>
```

# License

```
Copyright (c) 2017 Tomoyuki Sakurai <tomoyukis@reallyenglish.com>

Permission to use, copy, modify, and distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
```

# Author Information

Tomoyuki Sakurai <tomoyukis@reallyenglish.com>

This README was created by [qansible](https://github.com/trombik/qansible)
