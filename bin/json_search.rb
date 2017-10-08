require 'optparse'

require_relative '../lib/users.rb'
require_relative '../lib/organizations.rb'
require_relative '../lib/tickets.rb'

userfile = './data/users.json'
orgfile = './data/organizations.json'
ticketfile = './data/tickets.json'

op = OptionParser.new do |opts|
  banner = <<-MSG
    Usage: ruby json_search.rb [-h] [-l [<set>]] [-s <set> [-f <field> <value>]]
    Try following command
    ruby json_search.rb -l
    MSG

  opts.banner = banner

  opts.on('-h', '--help', 'Print help') do
    puts banner
  end

  opts.on('-l', '--list', 'List all data sets') do
    msg = <<-MSG
      You Can search on following data sets:
      1. Users
      2. Tickets
      3. Organizations
      e.g. To search on user data set, run the following command:
      ruby json_search.rb -s users
      MSG

    puts msg
  end

  opts.on('-s SET', '--set SET', 'Choose a set') do |set|
    if 'users'.casecmp?(set)
      dataset = Users.new userfile
    elsif 'organizations'.casecmp?(set)
      dataset = Organizations.new orgfile
    elsif 'tickets'.casecmp?(set)
      dataset = Tickets.new ticketfile
    else
      puts 'Invalid data set'
      exit
    end

    msg = <<-MSG
        You can search on following fields for #{set}:
        #{dataset.class.search_fields}

        e.g. To search for id=10, run following command
        ruby json_search.rb -s #{set} -f _id 10
        This message is also displayed on
        ruby json_search.rb -s #{set} -l
        MSG

    OptionParser.new do |_opts1|
      opts.on('-f FIELD', '--field FIELD', 'search field') do |field|
        value = ARGV.shift
        puts "Searching for #{field}=#{value}"
        list = dataset.search(field, value)
        puts "Number of items matched: #{list.length}"
        result = Dataset.new(list)
        result.display
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
