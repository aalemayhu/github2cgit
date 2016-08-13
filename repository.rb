class Repository
  
  attr_accessor :name
  attr_accessor :description
  attr_accessor :owner
  attr_accessor :git_url

  def initialize(name, description, owner, git_url)
    @name = name
    @description = description
    @owner = owner
    @git_url = git_url
  end

  def local_path
    local_git_directory = ENV['CGIT_REPO_DIRECTORY'] || "/tmp"
    return "#{local_git_directory}/#{owner}/#{name}.git"
  end

  def to_string
      return "\nrepo.url=#{owner}/#{name}\n" \
      "repo.path=#{local_path}\n" \
      "repo.desc=#{description}\n" \
      "repo.owner=#{owner}\n"
  end
end
