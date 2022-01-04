# frozen_string_literal: true

require 'discordrb'
require 'logger'
require 'dotenv/load'

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
  "Pong! Time taken: #{Time.now - event.timestamp} seconds."
end

bot.command :user do |event|
  logger.debug("Message received from '#{event.author.username}' in server '#{event.server.name}' (##{event.channel.name}) : #{event.message}")
  logger.debug("Responded by user command with response time #{Time.now - event.timestamp} seconds")
  event.user.name
end

bot.run
