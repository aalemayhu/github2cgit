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

  def local_path(local_git_directory)
    return "#{local_git_directory}/#{owner}/#{name}.git"
  end

  def to_string(local_git_directory)
      return "\nrepo.url=#{name}\n" \
      "repo.path=#{local_path(local_git_directory)}\n" \
      "repo.desc=#{description}\n" \
      "repo.owner=#{owner}\n"
  end
end
