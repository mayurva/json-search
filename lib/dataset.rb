require 'json'

########
# This class serves as a base class for all other data sets
class Dataset
  @search_fields = []
  class << self
    attr_accessor :search_fields
  end

  attr_reader :list

  def initialize(file)
    file = File.read(file)
    @list = JSON.parse(file)
  end

  def search(field, value)
    result = []
    @list.each do |item|
      result.push(item) if item[field].to_s == value
    end
    result
  end
end
