require_relative './dataset.rb'

########
# class to store ticket list
class Tickets < Dataset
  @search_fields = %w[
    _id url external_id created_at type subject description priority status recipient
    submitter_id assignee_id organization_id tags has_incidents due_at via requester_id
  ]

  @descriptive_fields = %w[subject description]

  class << self
    attr_accessor :search_fields
  end

  def initialize(file)
    super
  end
end
