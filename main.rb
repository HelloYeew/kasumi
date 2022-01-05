# frozen_string_literal: true

require 'discordrb'
require 'logger'
require 'dotenv/load'
require 'json'

bot_config = JSON.parse(File.read('./version.json'))
COLOR = 14_584_191
FOOTER_MESSAGE = "Kasumi #{bot_config['version']}"
FOOTER_ICON = bot_config['icon_url']

# Initialize the bot
bot = Discordrb::Commands::CommandBot.new token: ENV['token'], prefix: ENV['prefix']

# Initialize the logger
logger = Logger.new('log_file.log', 'daily')
logger.level = if ENV['debug']
                 Logger::DEBUG
               else
                 Logger::INFO
               end
logger.formatter = proc do |severity, datetime, progname, msg|
  date_format = datetime.strftime('%Y-%m-%d %H:%M:%S')
  "#{date_format} [#{progname}@##{Process.pid}]: #{severity.ljust(5)} - #{msg}\n"
end

# Message to initialize the logger
logger.info('----------------------------')
logger.info('Log for Kasumi')
logger.info("Starting time : #{Time.now} (#{Time.now.zone})")
logger.info("Prefix : #{ENV['prefix']}")
logger.info("Debug mode : #{ENV['debug']}")
logger.info('----------------------------')

logger.info('You are currently use debug mode! Please use this mode only for development purpose.') if ENV['debug']

bot.message(with_text: 'Ping!') do |event|
  event.respond 'Pong!'
end

bot.command :ping do |event|
  # Return the time that the bot use to response
  logger.debug("Message received from '#{event.author.username}' in server '#{event.server.name}' (##{event.channel.name}) : #{event.message}")
  logger.debug("Responded by ping command with response time #{Time.now - event.timestamp} seconds")
  event.channel.send_embed do |embed|
    embed.colour = COLOR
    embed.title = 'Pong!'
    embed.description = "Time taken : #{((Time.now - event.timestamp)*1000).to_i} ms"
    embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: FOOTER_MESSAGE, icon_url: FOOTER_ICON)
  end
end

bot.command :user do |event|
  # Return the embed of user info
  logger.debug("Message received from '#{event.author.username}' in server '#{event.server.name}' (##{event.channel.name}) : #{event.message}")
  logger.debug("Responded by user command with response time #{Time.now - event.timestamp} seconds")
  event.channel.send_embed do |embed|
    embed.colour = COLOR
    embed.title = "#{event.user.name}'s Profile"
    embed.description = 'Your full profile detail is here!'
    embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url: event.user.avatar_url.to_s)
    embed.add_field(name: 'Username', value: event.user.username)
    embed.add_field(name: 'Account Created', value: event.user.creation_time.to_s)
    embed.add_field(name: 'Bot?', value: event.user.current_bot?.to_s)
    embed.add_field(name: 'Status', value: event.user.status.to_s)
    embed.add_field(name: 'Playing', value: event.user.game) unless event.user.game.nil?
    embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: FOOTER_MESSAGE, icon_url: FOOTER_ICON)
  end
end

bot.run
