# MiniCli

The idea behind MiniCli is that apps should provide a common entry point that is self-explanatory.
A single executable script that lists all you can do with the app and some help about it.
This makes it very easy for new developers to use your app.
I. e:

```
> ./cli

Commands:
  cli auto [COMMAND]  # Re-runs the given command on any file change
  cli console         # Pry console with the app available
  cli help [COMMAND]  # Describe available commands or one specific command
  cli start           # Starts the Puma and any other required thread
  cli test            # Run the test suite
```

MiniCli it provides a set of easy to include ready-made Thor commands to help achieve that.
Ideally, libraries that provides their own commands would also provide this easy to include commands:

```ruby
require 'mini_cli'

class CLI < Thor
  include MiniCli::BaseModule

  add_startup_benchmark
  add_start_puma puma_args: %w{-p 22000}
  add_console_pry
  add_test_rspec
  add_auto_rerun
end
```

Invoke it as a regular Thor class:

```ruby
#!/usr/bin/env ruby

require_relative 'cli'
CLI.start
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

