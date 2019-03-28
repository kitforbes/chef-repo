# windows_baseline

Baseline Windows requirements.

## Requirements

### Platform

- Windows

### Cookbooks

- `chocolatey`
- `powershell`
- `windows`

## Attributes

- `node['powershell']['installation_reboot_mode']` - Defaults to `'immediate_reboot'`.
- `node['chocolatey']['upgrade']` - Defaults to `false`
- `node['chocolatey']['version']` - Defaults to `'0.10.11'`.
- `node['chocolatey']['install_vars']['chocolateyVersion']` - Defaults to `node['chocolatey']['version']`.
- `node['chocolatey']['install_vars']['chocolateyUseWindowsCompression']` - Defaults to `true`.
- `node['chocolatey']['config']['cache_location']` - Defaults to `nil`.
- `node['chocolatey']['config']['contains_legacy_package_installs']` - Defaults to `true`.
- `node['chocolatey']['config']['command_execution_timeout_seconds']` - Defaults to `2700`.
- `node['chocolatey']['config']['proxy']` - Defaults to `nil`.
- `node['chocolatey']['config']['proxy_user']` - Defaults to `nil`.
- `node['chocolatey']['config']['proxy_password']` - Defaults to `nil`.
- `node['chocolatey']['config']['web_request_timeout_seconds']` - Defaults to `30`.
- `node['chocolatey']['config']['proxy_bypass_list']` - Defaults to `nil`.
- `node['chocolatey']['config']['proxy_bypass_on_local']` - Defaults to `true`.
- `node['chocolatey']['features']['checksum_files']` - Defaults to `true`.
- `node['chocolatey']['features']['auto_uninstaller']` - Defaults to `true`.
- `node['chocolatey']['features']['allow_global_confirmation']` - Defaults to `false`.
- `node['chocolatey']['features']['fail_on_auto_uninstaller']` - Defaults to `false`.
- `node['chocolatey']['features']['fail_on_standard_error']` - Defaults to `false`.
- `node['chocolatey']['features']['allow_empty_checksums']` - Defaults to `false`.
- `node['chocolatey']['features']['allow_empty_checksums_secure']` - Defaults to `true`.
- `node['chocolatey']['features']['powershell_host']` - Defaults to `true`.
- `node['chocolatey']['features']['log_environment_values']` - Defaults to `false`.
- `node['chocolatey']['features']['virus_check']` - Defaults to `false`.
- `node['chocolatey']['features']['fail_on_invalid_or_missing_license']` - Defaults to `false`.
- `node['chocolatey']['features']['ignore_invalid_options_switches']` - Defaults to `false`.
- `node['chocolatey']['features']['use_package_exit_codes']` - Defaults to `true`.
- `node['chocolatey']['features']['use_fips_compliant_checksums']` - Defaults to `false`.
- `node['chocolatey']['features']['show_non_elevated_warnings']` - Defaults to `true`.
- `node['chocolatey']['features']['show_download_progress']` - Defaults to `false`.
- `node['chocolatey']['features']['stop_on_first_package_failure']` - Defaults to `true`.
- `node['chocolatey']['features']['use_remembered_arguments_for_upgrades']` - Defaults to `false`.
- `node['chocolatey']['features']['scripts_check_last_exit_code']` - Defaults to `false`.
- `node['chocolatey']['features']['ignore_unfound_packages_on_upgrade_outdated']` - Defaults to `false`.
- `node['chocolatey']['features']['remove_package_information_on_uninstall']` - Defaults to `true`.
- `node['chocolatey']['features']['log_without_color']` - Defaults to `false`.
- `node['chocolatey']['allow_gallery']` - Defaults to `true`.
- `node['chocolatey']['sources']` - Defaults to `[]`.

## Recipes

- `windows_baseline::chocolatey`
- `windows_baseline::default`
- `windows_baseline::features`
- `windows_baseline::powershell`
- `windows_baseline::user_settings`

## Maintainer

Maintainer:: Chris Forbes ([chef@chrisforbes.dev](chef@chrisforbes.dev))

## License

```
The MIT License (MIT)

Copyright (c) 2018 The Authors

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```
