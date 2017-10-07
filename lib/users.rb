require 'json'

########
# class to store user list
class Users
  @search_fields = %w[
    _id url external_id name alias created_at active verified shared locale timezone
    last_login_at email phone signature organization_id tags suspended role
  ]
  class << self
    attr_accessor :search_fields
  end

  attr_reader :user_list
  def initialize(file)
    file = File.read(file)
    @user_list = JSON.parse(file)
  end

  def search(field, value)
    result = []
    @user_list.each do |user|
      result.push(user) if user[field].to_s == value
    end
    result
  end
end
