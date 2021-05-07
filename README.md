# SystemCAStore

<!-- MDOC !-->

Functions to access the system CA store.

Supported operating systems:

* macOS
* Linux

## Examples

```elixir
# on macOS
SystemCAStore.file_path()
#=> "/Users/me/system_castore/_build/dev/lib/system_castore/priv/cacerts.pem"

# on Linux
SystemCAStore.file_path()
#=> "/etc/ssl/certs/ca-certificates.crt"
```

<!-- MDOC !-->

## License

Copyright (c) 2021 Wojtek Mach

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at [http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
