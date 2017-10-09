require_relative './dataset.rb'

########
# class to store organizations list
class Organizations < Dataset
  @search_fields = %w[
    _id url external_id name domain_names created_at details shared_tickets tags
  ]

  @descriptive_fields = %w[name details]

  class << self
    attr_accessor :search_fields
  end

  def initialize(file)
    super
  end
end
