module Cgit

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

  def map_to_cgit_repos(github_repository_payload)
    cgit_repos = []
    github_repository_payload.each do |repo|
      name = repo["name"]
      description = repo["description"]
      owner = repo["owner"]["login"]
      git_url = repo["git_url"]
      cgit_repos.push(Repository.new(name, description, owner, git_url))
    end
    return cgit_repos
  end

  def persist(directory, path, repositories)
    tmp_path = "#{path}.tmp"
    config_file = File.open(tmp_path, 'w')
    repositories.each  do |repo|
      local_path = "#{directory}/#{repo.owner}/#{repo.name}.git" # is this right?
      if File.directory?(local_path)
        runInBackground("cd #{local_path} && git remote update &")
      else
        runInBackground("git clone --mirror --quiet #{repo.git_url} #{local_path} &")
      end
      config_file.write(repo.to_string(directory))
    end

    config_file.close unless config_file.nil?
    FileUtils.mv(tmp_path, path)
  end
end
