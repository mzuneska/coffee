#! /usr/bin/env ruby
require 'fileutils'

path_to_coffee = File.join(File.dirname(File.expand_path(__FILE__)), 'coffee.rb')
brew_path = '/usr/local/bin/brew'
File.open(brew_path, 'w') do |file|
  # Maybe can use 'which' to get current ruby path but I think rvm switches it out
  file.write("#! /usr/bin/env ruby\n")
  file.write("require '#{path_to_coffee}'\n")
  file.write("Coffee::FrenchPress.new.brew")
end
FileUtils.chmod(0755, brew_path)
p "Created #{brew_path}"

FileUtils::Verbose.chmod(0744, 'coffee.rb')
FileUtils.copy('mail.yaml.example', 'mail.yaml', :preserve => true)
p "Created mail.yaml"