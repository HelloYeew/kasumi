# frozen_string_literal: true

require 'discordrb'
require 'logger'
require 'dotenv/load'

bot = Discordrb::Commands::CommandBot.new token: ENV['token'], prefix: ENV['prefix']

# Initialize the logger
logger = Logger.new('log_file.log','daily')
logger.level = Logger::DEBUG
logger.formatter = proc do |severity, datetime, progname, msg|
  date_format = datetime.strftime("%Y-%m-%d %H:%M:%S")
  "#{date_format} [#{progname}@##{Process.pid}]: #{severity.ljust(5)} - #{msg}\n"
end

# Message to initialize the logger
logger.info('----------------------------')
logger.info('Log for Kasumi')
logger.info("Starting time : #{Time.now} (#{Time.now.zone})")
logger.info("Prefix : #{ENV['prefix']}")
logger.info('----------------------------')

bot.message(with_text: 'Ping!') do |event|
  event.respond 'Pong!'
end

bot.command :ping do |event|
  # Return the time that the bot use to response
  logger.info("Message received from '#{event.author.username}' in server '#{event.server.name}' (##{event.channel.name}) : #{event.message}")
  logger.info("Responded by ping command with response time #{Time.now - event.timestamp} seconds")
  "Pong! Time taken: #{Time.now - event.timestamp} seconds."
end

bot.command :user do |event|
  # Commands send whatever is returned from the block to the channel. This allows for compact commands like this,
  # but you have to be aware of this so you don't accidentally return something you didn't intend to.
  # To prevent the return value to be sent to the channel, you can just return `nil`.
  logger.info("Message received from '#{event.author.username}' in server '#{event.server.name}' (##{event.channel.name}) : #{event.message}")
  logger.info("Responded by user command with response time #{Time.now - event.timestamp} seconds")
  event.user.name
end

bot.run
