# kasumi-ruby
 A rewrite of [Kasumi](https://github.com/HelloYeew/kasumi-old) in Ruby
 
## Invite link

You can invite the bot to your server by use [this link](https://discord.com/oauth2/authorize?client_id=806810705205395456&permissions=8&scope=bot)

## Start developing Kasumi

### Install package using bundle

If you don't have `bundle` installed in `gem` or don't sure run this command to install it:

```shell
gem install bundler
```

Then install the requirements gem by using bundle:

```shell
bundle install
```

## Environment file
Before you can start running Kasumi, you must set the environment variable by creating `.env` file first with following contents:

```dotenv
token=yout-bot-token
prefix=!
debug=true
```

Note : If you are running the bot on the real usage please set `debug=false`
