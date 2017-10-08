require 'json'

########
# This class serves as a base class for all other data sets
class Dataset
  @search_fields = []
  class << self
    attr_accessor :search_fields
  end

  attr_reader :list

  # A new dataset may be initialized by passing an array of another dataset, or
  # by loading the data set from file
  def initialize(list)
    if list.is_a?(Array)
      @list = list
    else
      file = File.read(list)
      @list = JSON.parse(file)
    end
  end

  def search(field, value)
    result = []
    @list.each do |item|
      if item[field].is_a?(Array) && item[field].include?(value)
        result.push(item)
      elsif item[field].to_s == value
        result.push(item)
      end
    end
    result
  end

  def display
    @list.each do |item|
      puts '--------------------------------------------------------------'
      item.each do |k, v|
        printf "%-25s %s\n", k, v
      end
    end
    puts '--------------------------------------------------------------'
  end
end
