require_relative "auth.rb"

class User
  @@users = []
  attr_accessor :id, :username, :password

  def initialize(username, password)
    @username = username
    @password = Auth.create_hash_digest(password)
    @id = @@users.length + 1

    @@users << self
  end

  # Return all users from Array
  def self.all
    @@users
  end

  # Populate the users Array
  def self.seed
    users = [{username: "joe", password: "password1"}, {username: "john", password: "password2"}, {username: "jack", password: "password3"}]

    users.each do |user|
      User.new(user[:username], user[:password])
    end
  end

  def self.find(id)
    self.all.find { |user| user.id == id }
  end
end