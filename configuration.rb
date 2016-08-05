class Configuration
  
  attr_accessor :user
  attr_accessor :endpoint
  attr_accessor :file_path
  attr_accessor :directory
  attr_accessor :orgMode

  def initialize(user, endpoint, file_path, directory, orgMode)
    @user = user
    @endpoint = endpoint
    @file_path = file_path
    @directory = directory
    @directory = orgMode
  end

  def url()
    if orgMode
      return "https://api.github.com/orgs/#{user}/repos"
    end
    return "https://api.github.com/users/#{user}/#{endpoint}"
  end
end
