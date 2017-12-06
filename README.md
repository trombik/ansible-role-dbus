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
| `dbus_conf_file` | Path to `system-local.conf` | `{{ dbus_conf_dir }}/system-local.conf` |
| `dbus_system_local_config` | Content of `system-local.conf` | See below |

## `dbus_system_local_config`

```xml
<!DOCTYPE busconfig PUBLIC "-//freedesktop//DTD D-Bus Bus Configuration 1.0//EN"
 "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
 <busconfig></busconfig>
```

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

# Dependencies

None

# Example Playbook

```yaml
- hosts: localhost
  roles:
    - ansible-role-dbus
  vars:
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
