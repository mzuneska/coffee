#!/usr/local/bin/ruby

module Coffee
  
  class Mail
    require 'net/smtp'
    require 'yaml'
  
    def initialize
      @config = YAML::load_file File.join(File.dirname(__FILE__), 'mail.yaml')
    end
  
    def send
      sender_name = @config['sender']['name']
      sender_address = @config['sender']['address']
      smtp_server = @config['mail']['server']
    
      @config['recipients'].each_pair do |recipient_name, recipient_address|
        message = "From: #{sender_name} <#{sender_address}>\nTo: #{recipient_name} <#{recipient_address}>\nSubject: #{@config['mail']['subject']}\n#{@config['mail']['message']}"
        Net::SMTP.start(smtp_server) { |smtp| smtp.send_message message, sender_address, recipient_address }
      end
    
    end
  
  end

  class FrenchPress
  
    COFFEE_STATUS = %w[C O F F E E]
    FOUR_MINUTES = 240
    UPDATE_INTERVAL = FOUR_MINUTES / (COFFEE_STATUS.size + 1)
  
    def initialize
      @status_count = 0
    end 
  
    def brew
      FOUR_MINUTES.times do |seconds_brewing|
        display_coffee_status_after_enough(seconds_brewing)
        sleep 1
      end
      notify
    end
  
  private
  
    def display_coffee_status_after_enough(seconds_brewing)
      if display_coffee_status?(seconds_brewing) then
        print COFFEE_STATUS[@status_count]
        STDOUT.flush
        @status_count += 1
      end
    end
  
    def display_coffee_status?(seconds_brewing)
      (@status_count < COFFEE_STATUS.size) && (seconds_brewing >= (UPDATE_INTERVAL * (@status_count + 1)))
    end
  
    def notify
      print "\n"
      `say Coffee is ready!`
      Coffee::Mail.new.send
    end
  
  end
end

Coffee::FrenchPress.new.brew