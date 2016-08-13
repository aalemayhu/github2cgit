require 'httparty'
require 'fileutils'
require_relative '../src/cgit_format.rb'
require_relative '../src/github_data_source.rb'
require_relative '../src/process.rb'

class App
  attr_accessor :user
  attr_accessor :local_git_directory
  attr_accessor :cgit_repositories_rcpath

  def initialize(user, directory, config_path)
    @user = user
    @local_git_directory = directory
    @cgit_repositories_rcpath = config_path
  end

  def run
    configs = [GithubDataSource.new(user, "starred", cgit_repositories_rcpath, local_git_directory),
               GithubDataSource.new(user, "repos", cgit_repositories_rcpath, local_git_directory)]

    cgit_repositories = []
    configs.each do |config|
      github_repositories = HTTParty.get(config.url())
      cgit_repositories += map_to_cgit_repos(github_repositories)
    end

    cgit_repositories = cgit_repositories.uniq { |repo| repo.git_url }

# Write config and clone all of the stuff

    tmp_path = "#{cgit_repositories_rcpath}.tmp"
    config_file = File.open(tmp_path, 'w')
    cgit_repositories.each  do |repo|
      local_path = "#{local_git_directory}/#{repo.owner}/#{repo.name}.git" # is this right?
      if File.directory?(local_path)
        runInBackground("cd #{local_path} && git remote update &")
      else
        runInBackground("git clone --mirror --quiet #{repo.git_url} #{local_path} &")
      end
      config_file.write(repo.to_string())
    end

    config_file.close unless config_file.nil?
    FileUtils.mv(tmp_path, cgit_repositories_rcpath)
  end
end