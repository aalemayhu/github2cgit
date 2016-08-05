class Configuration
  
  attr_accessor :user
  attr_accessor :endpoint
  attr_accessor :file_path
  attr_accessor :directory

  def initialize(user, endpoint, file_path, directory)
    @user = user
    @endpoint = endpoint
    @file_path = file_path
    @directory = directory
  end

  def url()
    return "https://api.github.com/users/#{user}/#{endpoint}"
  end
end
