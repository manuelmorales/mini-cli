# MiniCli

Simple command line interface for microservices built using Thor.
It provides basic commands:

```
Commands:
  cli auto [COMMAND]  # Re-runs the given command on any file change
  cli console         # Pry console with the app available
  cli help [COMMAND]  # Describe available commands or one specific command
  cli start           # Starts the Puma and any other required thread
  cli test            # Run the test suite
```


## Usage

Inherit from MiniCli::Base to provide the basic commands:

```ruby
require 'mini_cli'

class Cli < MiniCli::Base
end
```

Invoke it as a regular Thor class:

```ruby
#!/usr/bin/env ruby

require_relative 'cli'
PatioSessions::Cli.start
```


## Contributing

Do not forget to run the tests with:

```bash
rake
```

And bump the version with any of:

```bash
$ gem bump --version 1.1.1       # Bump the gem version to the given version number
$ gem bump --version major       # Bump the gem version to the next major level (e.g. 0.0.1 to 1.0.0)
$ gem bump --version minor       # Bump the gem version to the next minor level (e.g. 0.0.1 to 0.1.0)
$ gem bump --version patch       # Bump the gem version to the next patch level (e.g. 0.0.1 to 0.0.2)
```


## License

Released under the MIT License.
See the [LICENSE](LICENSE.txt) file for further details.

