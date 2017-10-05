require 'json'

########
# class to store user list
class Users
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
