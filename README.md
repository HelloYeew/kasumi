# kasumi-ruby
 A rewrite of [Kasumi](https://github.com/HelloYeew/kasumi-old) in Ruby

# Start developing Kasumi

## Install package using bundle

If you don't have `bundle` installed in `gem` or don't sure run this command to install it:

```shell
gem install bundler
```

Then install the requirements gem by using bundle:

```shell
bundle install
```

# Environment file
Before you can start running Kasumi, you must set the environment variable by creating `.env` file first with following contents:

```dotenv
token=yout-bot-token
prefix=!
debug=true
```

Note : If you are running the bot on the real usage please set `debug=false`