require 'json'

########
# This class serves as a base class for all other data sets
class Dataset
  @search_fields = []
  @descriptive_fields = []
  class << self
    attr_accessor :search_fields
    attr_accessor :descriptive_fields
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
      ###########
      # This is a complex condition
      # In the first part, if the search field is an array, we check if the value is included
      # in the array. This is applicable to multivalued fileds like tags.
      #
      # The second condition is for descriptive fields where we want to do partial match,
      # like names, description, etc. The condition  checks if the value is included in the field.
      #
      # The third condition does a simple value match
      next unless item[field].is_a?(Array) && item[field].include?(value) ||
                  self.class.descriptive_fields.include?(field) && item[field] && item[field].include?(value) ||
                  item[field].to_s == value

      result.push(item)
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
