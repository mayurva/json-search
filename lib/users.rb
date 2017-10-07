require 'dataset'

########
# class to store user list
class Users < Dataset
  @search_fields = %w[
    _id url external_id name alias created_at active verified shared locale timezone
    last_login_at email phone signature organization_id tags suspended role
  ]
  class << self
    attr_accessor :search_fields
  end

  def initialize(file)
    super
  end
end
