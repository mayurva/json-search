require 'optparse'
require 'yaml'

require_relative 'users.rb'

op = OptionParser.new do |opts|
  banner = <<-EOS
    Usage: ruby json_search.rb [-h] [-l [<set>]] [-s <set> [-f <field> <value>]]

    Try following command
    ruby json_search.rb -l

    EOS

  opts.banner = banner

  opts.on('-h', '--help', 'Print help') do
    puts banner
  end

  opts.on('-l', '--list', 'List all data sets') do
    msg = <<-EOS
      You Can search on following data sets:
      1. Users
      2. Tickets
      3. Organizations

      e.g. To search on user data set, run the following command:
      ruby json_search.rb -s users

      EOS

    puts msg
  end

  opts.on('-s SET', '--set SET', 'Choose a set') do |set|
    msg = <<-EOS

        You can search on following fields for #{set}:
        1. id
        2. role

        e.g. To search for id=10, run following command
        ruby json_search.rb -s users -f _id 10

        This message is also displayed on
        ruby json_search.rb -s users -l

        EOS

    OptionParser.new do |_opts1|
      opts.on('-f FIELD', '--field FIELD', 'search field') do |field|
        value = ARGV.shift
        puts "Searching for #{field}=#{value}"
        users = Users.new 'users.json'
        list =  users.search(field, value)
        puts "Number of items matched: #{list.length}"
        list.each do |item|
          puts "\n\n#{item.to_yaml}\n\n"
        end
        exit
      end

      opts.on('-l', '--list', 'List search fileds') do |_field|
        puts msg
        exit
      end
    end
    op.parse! ARGV
    puts msg
  end
end
op.parse! ARGV
