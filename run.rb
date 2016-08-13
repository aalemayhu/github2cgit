require 'httparty'
require 'fileutils'
require_relative 'cgit_format.rb'
require_relative 'configuration.rb'


user = ENV['GITHUB_USER'] || "scanf"
local_git_directory = ENV['CGIT_REPO_DIRECTORY'] || "/tmp"
cgit_repositories_rcpath = ENV['CGIT_REPOSITORIES_FILE'] || "/etc/github_repositories"

configs = [Configuration.new(user, "starred", cgit_repositories_rcpath, local_git_directory),
           Configuration.new(user, "repos", cgit_repositories_rcpath, local_git_directory)]

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
    puts `cd #{local_path} && git remote update &`
  else
    puts `git clone --mirror --quiet #{repo.git_url} #{local_path} &`
  end
  config_file.write(repo.to_string())
end

config_file.close unless config_file.nil?
FileUtils.mv(tmp_path, cgit_repositories_rcpath)
