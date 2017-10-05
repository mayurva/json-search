require 'optparse'
op = OptionParser.new do |opts|
  banner = <<-EOS
    Usage: ruby json-search.rb [-h] [-l [<set>]] [-s <set> [-f <field> <value>]]
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
      ruby json-search.rb --set users

      EOS

    puts msg
  end

  opts.on('-s SET', '--set SET', 'Choose a set') do |set|
    msg = <<-EOS

        You can search on following fields for #{set}:
        1. id
        2. name

        e.g. To search for id=10, run following command
        ruby json-search.rb -s users -f id 10

        EOS

    OptionParser.new do |_opts1|
      opts.on('-f FIELD', '--field FIELD', 'search field') do |field|
        value = ARGV.shift
        puts "Searching for #{field}=#{value}"
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
